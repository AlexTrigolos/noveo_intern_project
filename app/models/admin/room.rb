# frozen_string_literal: true

module Admin
  class Room < ApplicationRecord
    validates :room_name, presence: true, length: { minimum: 3, maximum: 50 }
    validates :short_description, presence: true, length: { minimum: 5, maximum: 100 }
    validates :long_description, presence: true, length: { minimum: 10, maximum: 1000 }
    validates :price, presence: true, numericality: { greater_than_or_equal_to: 0, less_than: BigDecimal(10**9) },
                      format: { with: /\A\d{1,9}(\.\d{1,2})?\z/ }
    has_many :room_photos, dependent: :destroy
    accepts_nested_attributes_for :room_photos
  end
end
