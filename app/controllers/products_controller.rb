class ProductsController < ApplicationController

  before_action :signed_in_user, only: [:create]

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
    @product = current_user.products.build(product_params)
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

  private
    
    def product_params
      params.require(:product).permit(:name, :description, :product_photo, :pro)
    end

end
