class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.string :room_name, null: false
      t.text :short_description, null: false
      t.text :long_description, null: false
      t.decimal :price, null: false

      t.timestamps
    end
  end
end
