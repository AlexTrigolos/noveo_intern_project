# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::Room, type: :model do
  it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0).is_less_than(BigDecimal(10**9)) }
  it { is_expected.to validate_length_of(:room_name).is_at_least(3).is_at_most(50) }
  it { is_expected.to validate_length_of(:short_description).is_at_least(5).is_at_most(100) }
  it { is_expected.to validate_length_of(:long_description).is_at_least(10).is_at_most(1000) }
  it { is_expected.to validate_presence_of(:room_name) }
  it { is_expected.to validate_presence_of(:short_description) }
  it { is_expected.to validate_presence_of(:long_description) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to have_many(:room_photos).dependent(:destroy) }
  it { is_expected.to accept_nested_attributes_for(:room_photos) }
  it { is_expected.to have_many(:rooms_bookings).dependent(:destroy) }
end
