# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::RoomPhoto, type: :model do
  it { is_expected.to belong_to(:room) }
  it { is_expected.to validate_presence_of(:photo) }
end
