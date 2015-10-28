class ChangeIndexInProducts < ActiveRecord::Migration
  def change
    remove_column :products, :user_id
    add_column    :products, :shop_owner_id, :integer
  end
end
