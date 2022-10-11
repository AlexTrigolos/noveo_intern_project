# frozen_string_literal: true

class AddIndexToBookings < ActiveRecord::Migration[7.0]
  def change
    add_index :bookings, :booking_token, unique: true
  end
end
