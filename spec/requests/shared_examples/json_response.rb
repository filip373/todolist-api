# frozen_string_literal: true

RSpec.shared_examples 'json response' do |status|
  it "has #{status} http status" do
    expect(response).to have_http_status(status)
  end

  it 'contains json content type' do
    expect(response.content_type).to eq('application/json')
  end
end
