# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/admin/confirmed_bookings_files', type: :request do
  let(:valid_attributes) do
    { file: 'file_name.csv' }
  end

  describe 'not authorized' do
    describe 'GET /index' do
      it 'redirect to root' do
        Admin::ConfirmedBookingsFile.create! valid_attributes
        get admin_confirmed_bookings_files_url
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'GET /download' do
      it 'redirect to root' do
        confirmed_bookings_file = Admin::ConfirmedBookingsFile.create! valid_attributes
        get download_admin_confirmed_bookings_file_url(confirmed_bookings_file)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
