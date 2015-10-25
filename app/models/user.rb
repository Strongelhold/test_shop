class User < ActiveRecord::Base
  validates :password, presence: true, length: { minimum: 6 }
  validates :name, presence: true, length: { minimum: 3, maximum: 15 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
end
