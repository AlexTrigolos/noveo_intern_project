class Admin::Review < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  validates :email, presence: true, length: { maximum: 105 },
            format: { with: VALID_EMAIL_REGEX }
  validates :review, presence: true, length: { minimum: 5, maximum: 1000 }
  before_save { self.email = email.downcase }
end
