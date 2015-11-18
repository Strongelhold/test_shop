class User < ActiveRecord::Base
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, :on => :create
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  self.inheritance_column = :_type_enabled # I was broke the STI so it's need
  
  before_save { email.downcase! }
  before_create :create_remember_token

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def admin?
    type == 'Admin'
  end

  def shop_owner?
    type == 'ShopOwner'
  end

  def guest?
    type == 'Guest'
  end

  private

    def create_remember_token
      self.remember_token = encrypt(new_remember_token)
    end
end
