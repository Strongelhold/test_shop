class ProductsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
  end

  private
    
    def product_params
      params.requre(:product).permit(:name, :description)
    end

end
