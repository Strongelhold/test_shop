class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(:id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
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
