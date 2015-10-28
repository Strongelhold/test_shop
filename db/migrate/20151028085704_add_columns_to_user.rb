class AddColumnsToUser < ActiveRecord::Migration
  def change
    remove_column :users, :name
    add_column    :users, :first_name, :string
    add_column    :users, :last_name,  :string
    add_column    :users, :birthday,   :string
    add_column    :users, :shop_name,  :string
 end
end
