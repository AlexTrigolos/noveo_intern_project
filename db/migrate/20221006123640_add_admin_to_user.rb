# frozen_string_literal: true

class AddAdminToUser < ActiveRecord::Migration[7.0]
  def change
    change_table :users, bulk: true do |t|
      t.boolean :admin, default: false, null: false
      t.boolean :check_reviews, default: false, null: false
      t.boolean :change_rooms, default: false, null: false
      t.boolean :confirms_reservations, default: false, null: false
    end
  end
end
