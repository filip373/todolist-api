RSpec.shared_context 'created auth user' do
  before do
    create :user, oauth_user_id: 'google-oauth2|117517435972086757760'
  end
end
