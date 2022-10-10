class CreateConfirmedBookingsFiles < ActiveRecord::Migration[7.0]
  def change
    create_table :confirmed_bookings_files do |t|
      t.string :file

      t.timestamps
    end
  end
end
