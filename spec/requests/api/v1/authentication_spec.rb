# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  describe 'access some API endpoint' do
    let(:subject_request) { get api_v1_note_path(note.id), headers: headers }
    let(:note) { create :note, title: 'second title', content: 'second' }

    context 'without authorization header' do
      before { subject_request }
      let(:headers) { {} }
      it_behaves_like 'json response', :not_found
    end

    context 'with authorization header' do
      let(:headers) { { authorization: auth_header } }

      context 'and incorrect header format' do
        before { subject_request }
        let(:auth_header) { JWTHelper.valid_jwt.to_s }
        it_behaves_like 'json response', :not_found
      end

      context 'and correct header format' do
        let(:stubbed_request) do
          VCR.use_cassette('auth0_jwks') { subject_request }
        end

        context 'and invalid JWT' do
          before { stubbed_request }
          let(:auth_header) { "Bearer #{JWTHelper.invalid_jwt}" }
          it_behaves_like 'json response', :not_found
        end

        context 'and valid JWT' do
          let(:auth_header) { "Bearer #{JWTHelper.valid_jwt}" }

          context 'and user from JWT does NOT exist' do
            include_context('created auth user')
            before { stubbed_request }
            it_behaves_like 'json response', :ok
          end

          context 'and user from JWT exists' do
            before { stubbed_request }
            it_behaves_like 'json response', :not_found
          end
        end
      end
    end
  end
end
