class CreateRoomPhotos < ActiveRecord::Migration[7.0]
  def change
    create_table :room_photos do |t|
      t.integer :room_id, null: false
      t.string :photo, null: false

      t.timestamps
    end
  end
end
