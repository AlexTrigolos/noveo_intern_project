# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::RoomPhotosController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/admin/room_photos').to route_to('admin/room_photos#index')
    end

    it 'routes to #show' do
      expect(get: '/admin/room_photos/1').to route_to('admin/room_photos#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/admin/room_photos/1/edit').to route_to('admin/room_photos#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/admin/room_photos').to route_to('admin/room_photos#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/admin/room_photos/1').to route_to('admin/room_photos#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/admin/room_photos/1').to route_to('admin/room_photos#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/admin/room_photos/1').to route_to('admin/room_photos#destroy', id: '1')
    end
  end
end
