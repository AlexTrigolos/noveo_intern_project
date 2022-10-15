# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::Review, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:review) }
  it { is_expected.to validate_length_of(:name).is_at_least(3).is_at_most(25) }
  it { is_expected.to validate_length_of(:email).is_at_most(105) }
  it { is_expected.to validate_length_of(:review).is_at_least(5).is_at_most(1000) }
end
