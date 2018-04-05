# frozen_string_literal: true

RSpec.shared_context 'created auth user' do
  let!(:authenticated_user) do
    create :user, oauth_id: 'google-oauth2|117517435972086757760'
  end
end
