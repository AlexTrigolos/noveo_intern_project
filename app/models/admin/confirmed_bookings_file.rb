class Admin::ConfirmedBookingsFile < ApplicationRecord
  validates :room_name, presence: true
end
