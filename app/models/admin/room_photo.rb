# frozen_string_literal: true

module Admin
  class RoomPhoto < ApplicationRecord
    mount_uploader :photo, PhotoUploader
    belongs_to :room
    validates :photo, presence: true
  end
end
