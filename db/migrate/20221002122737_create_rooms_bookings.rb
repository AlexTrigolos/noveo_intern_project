class CreateRoomsBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms_bookings do |t|
      t.references :booking, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
