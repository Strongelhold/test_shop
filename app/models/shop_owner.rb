class ShopOwner < User

  has_many :products, dependent: :destroy
  
  validates :password,  length: { minimum: 8 }
  validates :shop_name, presence: true
  validates :avatar,    presence: true

  mount_uploader :avatar, PhotoUploader
end
