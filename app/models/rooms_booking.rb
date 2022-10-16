# frozen_string_literal: true

class RoomsBooking < ApplicationRecord
  belongs_to :admin_booking, class_name: 'Admin::Booking'
  belongs_to :admin_room, class_name: 'Admin::Room'
end
