# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::ConfirmedBookingsFilesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/admin/confirmed_bookings_files').to route_to('admin/confirmed_bookings_files#index')
    end

    it 'routes to #download' do
      expect(get: '/admin/confirmed_bookings_files/1/download').to route_to('admin/confirmed_bookings_files#download',
                                                                            id: '1')
    end
  end
end
