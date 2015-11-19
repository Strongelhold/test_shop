class ProductsController < ApplicationController

  before_action :current_shop_owner, only: [:create]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    case
    when !signed_in?              then render 'show'
    when current_user.admin?      then render 'products/for_admins/show'
    when current_user.guest?      then render 'products/for_guests/show'
    when current_user.shop_owner? then render 'products/for_shop_owners/show'
    end
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
    authorize @product
    @product.update_attributes(product_params)
    flash[:success] = 'Product marked like Pro'
    redirect_to @product
  end

  def buy
    @product = Product.find(params[:product_id])
    authorize @product
    @photo_url = TransactionService.call
    if TransactionService.successful?(@photo_url) 
      flash[:danger] = 'You cannot buy this product cause thubmUrl > url'
      send_error_mail_to_admin
      redirect_to @product
    else
      ProductsMailer.product_bought(@product, current_user.email, @photo_url['url']).deliver_now
      send_mail_to_admin
      redirect_to(root_url)
    end
  end
  
  def send_mail_to_admin
    @id = TransactionService.query
    @users = User.all
    @users.each do |u|
      if u.admin?
        ProductsMailer.admin_notification(@id, u.email).deliver_now
      end
    end
  end

  def send_error_mail_to_admin
    @users = User.all
    @users.each do |u|
      if u.admin?
        ProductsMailer.buy_product_error(current_user.email, u.email).deliver_now
      end
    end
  end

  private
    
    def product_params
      params.require(:product).permit(:name, :description, :product_photo, :pro)
    end

    def current_shop_owner
      if current_user.shop_owner?
        @current_shop_owner = ShopOwner.find_by_id(current_user.id)
      end
    end
end
