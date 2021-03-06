class Product < ActiveRecord::Base
  validates :name,        presence: true, length: { minimum: 3 }
  validates :description, presence: true, length: { maximum: 150 }

  belongs_to :shop_owner

  mount_uploader :product_photo, PhotoUploader
end
