class GuestsController < ApplicationController
  
  def show
    @guest = Guest.find(params[:id])
  end

  def new
    if signed_in?
      redirect_to(root_url)
    else
      @guest = Guest.new
    end
  end

  def create
    if signed_in?
      redirect_to(root_url)
    else
      @guest = Guest.new(guest_params)
      if @guest.save
        sign_in @guest
        flash[:notice] = 'Welcome!'
        redirect_to @guest
      end
    end
  end

  private

    def guest_params
      params.require(:guest).permit(:email, :password)
    end
end
