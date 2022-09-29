class RoomPhoto < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  belongs_to :room, :class_name => 'Admin::Room'
  validates :room_id, :photo, presence: true
end
