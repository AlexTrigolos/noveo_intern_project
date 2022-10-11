# frozen_string_literal: true

class Booking < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :booking_token, :check_in_date, :check_out_date, :number_people, :email, presence: true
  validates :email, length: { maximum: 105 }, format: { with: VALID_EMAIL_REGEX }
  before_save { self.email = email.downcase }
  belongs_to :room
  validates :booking_token, length: { minimum: 24 }, uniqueness: { case_sensitive: false }
  validates :number_people, numericality: { greater_than: 0 }
  has_many :rooms_bookings, dependent: :destroy
end
