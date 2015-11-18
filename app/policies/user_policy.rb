class UserPolicy < ApplicationPolicy
  attr_accessor :error_message

  def update?
    if user.admin?
      return true
    else
      @error_message = 'You are not allowed to do this!'
      return false
    end
  end
end
