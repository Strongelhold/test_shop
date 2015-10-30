class Admin < User
  validates :password,       presence: true, length: { minimum: 10 }, :on => :create
  validates :first_name,     presence: true, :on => :create
  validates :last_name,      presence: true, :on => :create
  validates :birthday,       presence: true, :on => :create
  validates :avatar,         presence: true, :on => :create
  validates :passport_photo, presence: true, :on => :create
  
  mount_uploader :avatar,         PhotoUploader
  mount_uploader :passport_photo, PhotoUploader
  
end
