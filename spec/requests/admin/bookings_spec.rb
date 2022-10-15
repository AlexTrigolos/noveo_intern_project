# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'admin/bookings', type: :request do
  let(:room) do
    Room.create!(room_name: 'room name', short_description: 'short', long_description: 'long description', price: 9.99)
  end

  let(:valid_attributes) do
    { email: 'alex@mail.ru', confirmed: false, booking_token: SecureRandom.base58(rand(24..40)), number_people: 1,
      room_id: room.id, check_in_date: '2023-01-01', check_out_date: '2023-02-02' }
  end

  let(:invalid_attributes) do
    { email: '', confirmed: nil, booking_token: '',
      number_people: -1, room_id: -1, check_in_date: '2023-01-01', check_out_date: '2023-02-02' }
  end

  describe 'not authorized' do
    describe 'GET /index' do
      it 'index redirect to root' do
        Admin::Booking.create! valid_attributes
        get admin_bookings_url
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'GET /show' do
      it 'show redirect to root' do
        booking = Admin::Booking.create! valid_attributes
        get admin_booking_url(booking)
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'PATCH /update' do
      context 'with valid parameters' do
        let(:new_attributes) { {} }

        it 'redirect to root' do
          booking = Admin::Booking.create! valid_attributes
          patch admin_booking_url(booking), params: { admin_booking: new_attributes }
          booking.reload
          expect(response).to redirect_to(root_path)
        end
      end

      context 'with invalid parameters' do
        it 'redirect to root' do
          booking = Admin::Booking.create! valid_attributes
          patch admin_booking_url(booking), params: { admin_booking: invalid_attributes }
          expect(response).to redirect_to(root_path)
        end
      end
    end

    describe 'DELETE /destroy' do
      it 'destroy redirect to root' do
        booking = Admin::Booking.create! valid_attributes
        delete admin_booking_url(booking)
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'GET /confirmed_bookings' do
      it 'confirmed_bookings redirect to root' do
        Admin::Booking.create! valid_attributes
        get confirmed_bookings_admin_bookings_url
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
