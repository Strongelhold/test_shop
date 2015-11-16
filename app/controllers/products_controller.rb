class ProductsController < ApplicationController

  before_action :current_shop_owner, only: [:create]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = current_shop_owner.products.build(product_params)
    @product.shop_name = current_shop_owner.shop_name
    if @product.save
      flash[:success] = 'Product added'
      redirect_to products_path
    else
      flash[:danger] = 'There are some mistakes'
      render 'products#new'
    end
  end

  def edit
  end

  def update
    @product = Product.find(params[:id])
    @product.update_attributes(product_params)
    flash[:success] = 'Product marked like Pro'
    redirect_to @product
  end

  def buy
    product = Product.find(params[:product_id])
      case false
      when signed_in?
        flash[:danger] = 'Sign in first!'
        redirect_to product
      when (current_user.type == 'Guest')
        flash[:danger] = 'You are not guest!'
        send_error_mail_to_admin
        redirect_to product
      when (!product.pro)
        flash[:danger] = 'You are not allowed to buy PRO products'
        send_error_mail_to_admin
        redirect_to product
      when (current_user.email.scan('.com') == [])
        flash[:danger] = 'You are not allowed to buy products cause your mail in .com zone'
        send_error_mail_to_admin
        redirect_to product
      when (product.shop_name.nil?)
        flash[:danger] = 'Product name are nil. You can not buy this product'
        send_error_mail_to_admin
        redirect_to product
      else
        @photo_url = ProductsController.call
        if @photo_url['thumbnailUrl'].split('/').last.to_i(16) > @photo_url['url'].split('/').last.to_i(16)
          flash[:danger] = 'You cannot buy this product cause thubmUrl > url'
          send_error_mail_to_admin
          redirect_to product
        else
          ProductsMailer.product_bought(product, current_user.email, @photo_url['url']).deliver_now
          send_mail_to_admin
          redirect_to(root_url)
        end
      end
  end
  
  def send_mail_to_admin
    @id = ProductsController.post_query
    @admins = Admin.all
    @admins.each do |a|
      ProductsMailer.admin_notification(@id, a.email).deliver_now
    end
  end

  def send_error_mail_to_admin
    @admins = Admin.all
    @admins.each do |a|
      ProductsMailer.buy_product_error(current_user.email, a.email).deliver_now
    end
  end

  def self.call
    uri = URI.parse('http://jsonplaceholder.typicode.com/photos/')

    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)

    n = rand(5000)
    response = http.request(request)

    photo_url = JSON::parse(response.body)
    photo_url = photo_url[n]
  end

  def self.post_query
    uri = URI.parse('http://jsonplaceholder.typicode.com/todos/')
    parameters = { 'id' => '1' }
    response = Net::HTTP.post_form(uri, parameters)
    id = JSON::parse(response.body)
    id = id['id']
  end

  private
    
    def product_params
      params.require(:product).permit(:name, :description, :product_photo, :pro)
    end

    def current_shop_owner
      if current_user.type == 'ShopOwner'
        @current_shop_owner = ShopOwner.find_by_id(current_user.id)
      end
    end
end
