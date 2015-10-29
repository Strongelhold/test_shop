class ShopOwnersController < ApplicationController

  def show
    @shop_owner = ShopOwner.find(params[:id])
  end

  def new
    if signed_in?
      redirect_to(root_url)
    else
      @shop_owner = ShopOwner.new
    end
  end

  def create
    if signed_in?
      redirect_to(root_url)
    else
      @shop_owner = ShopOwner.new(shop_owner_params)
      sign_in(@shop_owner)
      flash[:notice] = "Welcome!"
      redirect_to @shop_owner
    end
  end

  private 
    def shop_owner_params
      params.require(:shop_owner).permit(:shop_name, :email, :password, :avatar)
    end
end
