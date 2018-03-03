# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Auth::Auths', type: :request do
  describe 'GET /auths/auth' do
    before { get auth_login_path }

    it 'returns redirection to auth0', :aggregate_failures do
      expect(response).to have_http_status(:found)
      expect(response)
        .to redirect_to(%r{\Ahttps://todolist-test\.eu\.auth0\.com})
    end
  end

  describe 'GET /auths/callback' do
    let(:req) { get auth_callback_path, params: params }

    context 'with error in query' do
      let(:params) { { error: 'some test error' } }

      it 'returns error in a body' do
        req
        expect(response.body).to eq('some test error')
      end
    end

    context 'with code in query' do
      let(:params) { { code: JWTHelper.valid_code } }

      it 'returns access token in a body' do
        VCR.use_cassette(
          'get_token_valid_code', match_requests_on: [:body_as_json]
        ) do
          req
        end
        expect(response.body).to eq(JWTHelper.valid_jwt)
      end
    end
  end
end
