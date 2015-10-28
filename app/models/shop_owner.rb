class ShopOwner < User

  has_many :products
  
  validates :password,  length: { minimum: 8 }
  validates :shop_name, presence: true
end
