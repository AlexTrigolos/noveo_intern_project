# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/rooms', type: :request do
  let(:valid_attributes) do
    { room_name: 'Room Name', short_description: 'MyText',
      long_description: 'MyText', price: 9.99 }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Room.create! valid_attributes
      get rooms_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      room = Room.create! valid_attributes
      get room_url(room)
      expect(response).to be_successful
    end
  end
end
