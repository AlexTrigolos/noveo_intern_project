class AddAdminToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :admin, :boolean, default: false, null: false
    add_column :users, :check_reviews, :boolean, default: false, null: false
    add_column :users, :change_rooms, :boolean, default: false, null: false
    add_column :users, :confirms_reservations, :boolean, default: false, null: false
  end
end
