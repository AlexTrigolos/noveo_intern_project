class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.string :email, null: false
      t.boolean :confirmed, null: false, default: false
      t.string :booking_token, null: false, unique: true
      t.date :check_in_date, null: false
      t.date :check_out_date, null: false
      t.integer :number_people, null: false
      t.integer :room_id, null: false

      t.timestamps
    end
  end
end
