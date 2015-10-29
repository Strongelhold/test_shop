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
    if (current_user.type == 'Guest') && signed_in? && (!product.pro)
      redirect_to(root_url)
    end
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
