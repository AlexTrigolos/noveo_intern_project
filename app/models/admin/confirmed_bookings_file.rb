# frozen_string_literal: true

module Admin
  class ConfirmedBookingsFile < ApplicationRecord
    validates :file, presence: true
  end
end
