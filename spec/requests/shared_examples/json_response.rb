# frozen_string_literal: true

RSpec.shared_examples 'json response' do |status|
  it "has #{status} http status and json content type", :aggregate_failures do
    expect(response).to have_http_status(status)
    expect(response.content_type).to eq('application/json')
  end
end
