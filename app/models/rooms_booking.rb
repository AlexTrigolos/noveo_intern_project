# frozen_string_literal: true

class RoomsBooking < ApplicationRecord
  belongs_to :booking
  belongs_to :room
end
