class AddAvatarAndPassportPhotoToUser < ActiveRecord::Migration
  def change
    add_column :users, :avatar,         :string
    add_column :users, :passport_photo, :string
  end
end
