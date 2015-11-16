class UsersController < ApplicationController
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    if signed_in?
      redirect_to(root_url)
    else
      @user = User.new
    end
  end

  def create
    if signed_in?
      redirect_to(root_url)
    else
      @user = User.new(user_params)
      if @user.save
        sign_in @user
        flash[:success] = 'Welcome!'
        redirect_to @user
      end
    end
  end
  
  def edit
  end

  def update
  end

  def change_type_to_guest
    user = User.find(params[:user_id])
    if user.update_attributes(:type => 'Guest')
      flash[:success] = 'Edit successful'
      redirect_to user
    else
      flash[:danger] = 'Edit unsuccessful'
      redirect_to user
    end
  end

  def change_type_to_shop_owner
    user = User.find(params[:user_id])
    if user.update_attributes(:type => 'Shop_owner')
      flash[:success] = 'Edit successful'
      redirect_to user
    else
      flash[:danger] = 'Edit unsuccessful'
      redirect_to user
    end
  end

  def change_type_to_admin
    user = User.find(params[:user_id])
    if user.update_attributes(:type => 'Admin')
      flash[:success] = 'Edit successful'
      redirect_to user
    else
      flash[:danger] = 'Edit unsuccessful'
      redirect_to user
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password)
    end
end
