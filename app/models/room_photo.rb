class RoomPhoto < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  belongs_to :room
  validates :room_id, :photo, presence: true
end
