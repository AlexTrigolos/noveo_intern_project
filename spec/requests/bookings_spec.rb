# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/bookings', type: :request do
  let(:room) do
    Room.create!(room_name: 'room name', short_description: 'short', long_description: 'long description', price: 9.99)
  end

  let(:valid_attributes) do
    { email: 'alex@mail.ru', confirmed: false, booking_token: SecureRandom.base58(rand(24..40)), number_people: 1,
      room_id: room.id, check_in_date: '2023-01-01', check_out_date: '2023-02-02' }
  end

  let(:invalid_dates_attributes) do
    { email: 'alex@mail.ru', confirmed: false, booking_token: SecureRandom.base58(rand(24..40)), number_people: 1,
      room_id: room.id, check_in_date: '2023-02-02', check_out_date: '2023-01-01' }
  end

  let(:invalid_attributes) do
    { email: '', confirmed: nil, booking_token: '',
      number_people: -1, room_id: -1, check_in_date: '2023-01-01', check_out_date: '2023-02-02' }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Booking.create! valid_attributes
      get bookings_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      booking = Booking.create! valid_attributes
      get booking_url(booking.booking_token)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_booking_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      post bookings_url, params: { booking: valid_attributes, room: room.id }
      booking = Booking.last
      get edit_booking_url(booking.booking_token)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Booking' do
        expect do
          post bookings_url, params: { booking: valid_attributes, room: room.id }
        end.to change(Booking, :count).by(1)
      end

      it 'redirects to the created booking' do
        post bookings_url, params: { booking: valid_attributes, room: room.id }
        expect(response).to redirect_to(booking_url(Booking.last.booking_token))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Booking' do
        expect do
          post bookings_url, params: { booking: invalid_attributes }
        end.not_to change(Booking, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post bookings_url, params: { booking: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with invalid dates parameters' do
      it 'does not create a new Booking' do
        expect do
          post bookings_url, params: { booking: invalid_dates_attributes }
        end.not_to change(Booking, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post bookings_url, params: { booking: invalid_dates_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        { email: 'alex@mail.ru', check_in_date: '2023-01-01', check_out_date: '2023-02-02', number_people: 3 }
      end

      it 'updates the requested booking' do
        post bookings_url, params: { booking: valid_attributes, room: room.id }
        booking = Booking.last
        patch booking_url(booking.booking_token), params: { booking: new_attributes }
        booking.reload
        expect(booking.confirmed).to be(false)
      end

      it 'redirects to the booking' do
        post bookings_url, params: { booking: valid_attributes, room: room.id }
        booking = Booking.last
        patch booking_url(booking.booking_token), params: { booking: new_attributes }
        booking.reload
        expect(response).to redirect_to(booking_url(booking.booking_token))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        post bookings_url, params: { booking: valid_attributes, room: room.id }
        booking = Booking.last
        patch booking_url(booking.booking_token), params: { booking: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with invalid dates parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        post bookings_url, params: { booking: valid_attributes, room: room.id }
        booking = Booking.last
        patch booking_url(booking.booking_token), params: { booking: invalid_dates_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested booking' do
      post bookings_url, params: { booking: valid_attributes, room: room.id }
      booking = Booking.last
      expect do
        delete booking_url(booking.booking_token)
      end.to change(Booking, :count).by(-1)
    end

    it 'redirects to the bookings list' do
      post bookings_url, params: { booking: valid_attributes, room: room.id }
      booking = Booking.last
      delete booking_url(booking.booking_token)
      expect(response).to redirect_to(bookings_url)
    end
  end
end
