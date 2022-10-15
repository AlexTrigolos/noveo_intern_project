# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/admin/rooms', type: :request do
  let(:valid_attributes) do
    { room_name: 'Room Name', short_description: 'MyText',
      long_description: 'my long description', price: 9.99 }
  end

  let(:invalid_attributes) do
    { room_name: '', short_description: '',
      long_description: '', price: '' }
  end

  describe 'not authorized' do
    describe 'GET /index' do
      it 'redirect to root' do
        Admin::Room.create! valid_attributes
        get admin_rooms_url
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'GET /show' do
      it 'redirect to root' do
        room = Admin::Room.create! valid_attributes
        get admin_room_url(room)
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'GET /new' do
      it 'redirect to root' do
        get new_admin_room_url
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'GET /edit' do
      it 'redirect to root' do
        room = Admin::Room.create! valid_attributes
        get edit_admin_room_url(room)
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'POST /create' do
      context 'with valid parameters' do
        it 'redirect to root' do
          post admin_rooms_url, params: { admin_room: valid_attributes }
          expect(response).to redirect_to(root_path)
        end
      end

      context 'with invalid parameters' do
        it 'redirect to root' do
          post admin_rooms_url, params: { admin_room: invalid_attributes }
          expect(response).to redirect_to(root_path)
        end
      end
    end

    describe 'PATCH /update' do
      context 'with valid parameters' do
        let(:new_attributes) { {} }

        it 'redirect to root' do
          room = Admin::Room.create! valid_attributes
          patch admin_room_url(room), params: { admin_room: new_attributes }
          room.reload
          expect(response).to redirect_to(root_path)
        end
      end

      context 'with invalid parameters' do
        it 'redirect to root' do
          room = Admin::Room.create! valid_attributes
          patch admin_room_url(room), params: { admin_room: invalid_attributes }
          expect(response).to redirect_to(root_path)
        end
      end
    end

    describe 'DELETE /destroy' do
      it 'redirect to root' do
        room = Admin::Room.create! valid_attributes
        delete admin_room_url(room)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
