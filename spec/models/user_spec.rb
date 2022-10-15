# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_length_of(:first_name).is_at_least(3).is_at_most(25) }
  it { is_expected.to validate_length_of(:last_name).is_at_least(3).is_at_most(30) }
  it { is_expected.to validate_length_of(:email).is_at_most(105) }
end
