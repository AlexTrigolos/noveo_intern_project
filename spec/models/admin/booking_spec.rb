# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::Booking, type: :model do
  it { is_expected.to have_many(:rooms_bookings).dependent(:destroy) }

  it { is_expected.to validate_presence_of(:booking_token) }
  it { is_expected.to validate_presence_of(:number_people) }
  it { is_expected.to validate_presence_of(:check_in_date) }
  it { is_expected.to validate_presence_of(:check_out_date) }
  it { is_expected.to validate_presence_of(:email) }

  # it { is_expected.to validate_uniqueness_of(:booking_token)  }
  it { is_expected.to validate_length_of(:booking_token).is_at_least(24) }
  it { is_expected.to validate_length_of(:email).is_at_most(105) }
  it { is_expected.to validate_numericality_of(:number_people).is_greater_than(0) }
end
