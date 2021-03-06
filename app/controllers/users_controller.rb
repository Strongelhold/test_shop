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
        redirect_to @user
      end
    end
  end
  
  def edit
  end

  def update
   # authorize current_user
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'Edit successful'
      redirect_to @user
    else
      flash[:danger] = 'Edit unsuccessful'
      redirect_to @user
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :type)
    end
end
