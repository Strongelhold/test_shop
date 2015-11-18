class ProductPolicy < ApplicationPolicy
  attr_accessor :error_message

  def create?
    user.shop_owner?
  end

  def update?
    user.admin?
  end

  def show?
    true
  end

  def buy?
    @error_message = case
      when !user then 'You must be logged'
      when !user.guest? then 'You are not guest!'
      when record.pro then 'You are not allowed to buy Pro products'
      when record.shop_name.nil? then 'Shop name are nil. You can\'t buy this product'
      when user.email.scan('.com').nil? then 'You are not allowed to buy products \'cause your mail in .com zone'
    else return true
    end
    return false
  end
end
