# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Auth::AuthsController, type: :routing do
  describe 'routing' do
    it 'routes to #login' do
      expect(get: '/auth/login').to route_to('auth/auths#login')
    end

    it 'routes to #callback' do
      expect(get: '/auth/callback').to route_to('auth/auths#callback')
    end
  end
end
