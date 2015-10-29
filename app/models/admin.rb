class Admin < User
  validates :password,       presence: true, length: { minimum: 10 }
  validates :first_name,     presence: true
  validates :last_name,      presence: true
  validates :birthday,       presence: true
  validates :avatar,         presence: true
  validates :passport_photo, presence: true
  
  mount_uploader :avatar,         PhotoUploader
  mount_uploader :passport_photo, PhotoUploader
  
end
