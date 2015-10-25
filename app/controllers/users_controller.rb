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
        flash[:success] = "Вы успешно зарегистрировались!"
        redirect_to @user
      end
    end
  end
  
  def edit
  end

  def update
  end

  private
    def user_params
      params.require(:user).permit(:name,:email,:password)
    end
end
