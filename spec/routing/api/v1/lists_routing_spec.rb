# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::ListsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/lists').to route_to('api/v1/lists#index')
    end

    it 'routes to #show' do
      expect(get: '/api/v1/lists/1').to route_to('api/v1/lists#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/api/v1/lists').to route_to('api/v1/lists#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/api/v1/lists/1').to route_to('api/v1/lists#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/api/v1/lists/1')
        .to route_to('api/v1/lists#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/api/v1/lists/1')
        .to route_to('api/v1/lists#destroy', id: '1')
    end
  end
end
