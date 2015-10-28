class Admin < User
  validates :password,   presence: true, length: { minimum: 10 }
  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :birthday,   presence: true
  
end
