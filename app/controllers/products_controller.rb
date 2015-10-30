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
      flash[:success] = "Product added"
      redirect_to products_path
    else
      flash[:danger] = "There are some mistakes"
      render 'products#new'
    end
  end

  def edit
  end

  def update
    @product = Product.find(params[:id])
    @product.update_attributes(product_params)
    flash[:success] = "Product marked like Pro"
    redirect_to @product
  end

  def buy
    product = Product.find(params[:product_id])
    if (current_user.type == 'Guest') && signed_in? && (!product.pro) && (current_user.email.scan('.com') == []) && (product.shop_name != nil) 
      @photo_url = ProductsController.call
      ProductsMailer.product_bought(product, current_user.email, @photo_url).deliver_now
      ProductsController.send_mail_to_admin
      redirect_to(root_url)
    else
      redirect_to product
    end
  end

  def self.send_mail_to_admin
    @id = ProductsController.post_query
    @admins = Admin.all
    @admins.each do |a|
      ProductsMailer.admin_notification(@id, a.email).deliver_now
    end
  end

  def self.call
    uri = URI.parse("http://jsonplaceholder.typicode.com/photos/")

    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)

    n = rand(5000)
    response = http.request(request)

    photo_url = JSON::parse(response.body)
    photo_url = photo_url[n]["url"]
    return photo_url
  end

  def self.post_query
    uri = URI.parse("http://jsonplaceholder.typicode.com/todos/")
    parameters = {"id" => "1" }
    response = Net::HTTP.post_form(uri, parameters)
    id = JSON::parse(response.body)
    id = id["id"]
    return id
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
