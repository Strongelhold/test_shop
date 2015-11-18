class ApplicationController < ActionController::Base
  include SessionsHelper
  include Pundit
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized(exception)
    flash[:danger] = exception.to_s
    redirect_to(request.referrer || root_url)
  end
end
