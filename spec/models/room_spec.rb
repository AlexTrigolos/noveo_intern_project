# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Room, type: :model do
  it { is_expected.to have_many(:room_photos).dependent(:destroy) }
  it { is_expected.to accept_nested_attributes_for(:room_photos) }
end
