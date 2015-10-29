class AdminsController < ApplicationController

  def show
    @admin = Admin.find(params[:id])
  end

  def new
    if signed_in?
      redirect_to(root_url)
    else
      @admin = Admin.new
    end
  end

  def create
    if signed_in?
      redirect_to(root_url)
    else
      @admin = Admin.new(admin_params)
      if @admin.save
        sign_in(@admin)
        flash[:notice] = "Welcome!"
        redirect_to @admin
      end
    end
  end

  private

    def admin_params
      params.require(:admin).permit(:first_name, :last_name, :email, :password, :avatar, :passport_photo, :birthday)
    end
end
