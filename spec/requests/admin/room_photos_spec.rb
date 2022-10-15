# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/admin/room_photos', type: :request do
  let(:room) do
    Room.create!(room_name: 'room name', short_description: 'short', long_description: 'long description', price: 9.99)
  end
  let(:valid_attributes) do
    { room_id: room.id, photo: fixture_file_upload('image.jpg') }
  end

  let(:invalid_attributes) do
    { room_id: -1, photo: '' }
  end

  describe 'not authorized' do
    describe 'GET /index' do
      it 'redirect to root' do
        Admin::RoomPhoto.create! valid_attributes
        get admin_room_photos_url
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'GET /show' do
      it 'redirect to root' do
        room_photo = Admin::RoomPhoto.create! valid_attributes
        get admin_room_photo_url(room_photo)
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'GET /edit' do
      it 'redirect to root' do
        room_photo = Admin::RoomPhoto.create! valid_attributes
        get edit_admin_room_photo_url(room_photo)
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'POST /create' do
      context 'with valid parameters' do
        it 'redirect to root' do
          post admin_room_photos_url, params: { admin_room_photo: valid_attributes }
          expect(response).to redirect_to(root_path)
        end
      end

      context 'with invalid parameters' do
        it 'redirect to root' do
          post admin_room_photos_url, params: { admin_room_photo: invalid_attributes }
          expect(response).to redirect_to(root_path)
        end
      end
    end

    describe 'PATCH /update' do
      context 'with valid parameters' do
        let(:new_attributes) { {} }

        it 'redirect to root' do
          room_photo = Admin::RoomPhoto.create! valid_attributes
          patch admin_room_photo_url(room_photo), params: { admin_room_photo: new_attributes }
          room_photo.reload
          expect(response).to redirect_to(root_path)
        end
      end

      context 'with invalid parameters' do
        it 'redirect to root' do
          room_photo = Admin::RoomPhoto.create! valid_attributes
          patch admin_room_photo_url(room_photo), params: { admin_room_photo: invalid_attributes }
          expect(response).to redirect_to(root_path)
        end
      end
    end

    describe 'DELETE /destroy' do
      it 'redirect to root' do
        room_photo = Admin::RoomPhoto.create! valid_attributes
        delete admin_room_photo_url(room_photo)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
