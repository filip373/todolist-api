# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API::V1::Lists', type: :request do
  include_context 'created auth user'
  let(:list_1) { create :list, title: 'first title' }
  let(:list_2) { create :list, title: 'second title', deadline: 1.day.since }
  let(:parsed_response) { JSON.parse response.body }

  describe 'GET /api/v1/lists' do
    before do
      list_1
      list_2
    end
    before do
      VCR.use_cassette('auth0_jwks') do
        auth_get api_v1_lists_path
      end
    end

    it_behaves_like 'json response', :ok

    it 'contains created lists' do
      first = List.new parsed_response[0]
      second = List.new parsed_response[1]
      expect(first).to eq(list_1)
      expect(second).to eq(list_2)
    end
  end

  describe 'GET /api/v1/lists/:id' do
    before do
      VCR.use_cassette('auth0_jwks') do
        auth_get api_v1_list_path(list_1.id)
      end
    end

    it_behaves_like 'json response', :ok

    it 'contains created list' do
      retrieved = List.new parsed_response
      expect(retrieved).to eq(list_1)
    end
  end

  describe 'POST /api/v1/lists' do
    subject do
      VCR.use_cassette('auth0_jwks') do
        auth_post api_v1_lists_path(list_params)
      end
    end
    before do
      allow(ListMailer).to receive(:new_list).and_return(stubbed_mailer)
    end
    let(:stubbed_mailer) { double deliver_later: nil }

    let(:list_params) do
      {
        list: {
          title: title,
          deadline: 1.day.since
        }
      }
    end

    context 'for valid list params' do
      let(:title) { 'some title' }

      it_behaves_like 'json response', :created do
        before { subject }
      end

      it 'changes lists count in db by 1' do
        expect { subject }.to change(List, :count).by(1)
      end

      it 'creates list for the current user' do
        subject
        expect(List.last.user).to eq(authenticated_user)
      end

      it 'calls ListMailer' do
        expect(ListMailer).to receive(:new_list)
        expect(stubbed_mailer).to receive(:deliver_later)
        subject
      end
    end

    context 'for invalid list params' do
      let(:title) { '' }

      it_behaves_like 'json response', :unprocessable_entity do
        before { subject }
      end

      it 'does NOT change lists count in db' do
        expect { subject }.not_to change(List, :count)
      end

      it 'does NOT call ListMailer' do
        expect(ListMailer).not_to receive(:new_list)
        expect(stubbed_mailer).not_to receive(:deliver_later)
        subject
      end
    end
  end

  describe 'PUT /api/v1/lists/:id' do
    before { list_1 }
    subject do
      VCR.use_cassette('auth0_jwks') do
        auth_put api_v1_list_path(list_params)
      end
    end

    let(:list_params) do
      {
        id: list_id,
        list: {
          title: title,
          deadline: 1.day.since
        }
      }
    end
    let(:title) { 'some valid title' }
    let(:list_id) { list_1.id }

    context 'for valid list params' do
      it_behaves_like 'json response', :ok do
        before { subject }
      end

      it 'does NOT change lists count in db' do
        expect { subject }.not_to change(List, :count)
      end
    end

    context 'for invalid list params' do
      let(:title) { '' }

      it_behaves_like 'json response', :unprocessable_entity do
        before { subject }
      end

      it 'does NOT change lists count in db' do
        expect { subject }.not_to change(List, :count)
      end
    end

    context 'for NOT existing list id' do
      let(:list_id) { list_1.id + 123 }

      it_behaves_like 'json response', :not_found do
        before { subject }
      end

      it 'does NOT change lists count in db' do
        expect { subject }.not_to change(List, :count)
      end
    end
  end

  describe 'DELETE /api/v1/lists/:id' do
    before { list_1 }
    subject do
      VCR.use_cassette('auth0_jwks') do
        auth_delete api_v1_list_path(list_id)
      end
    end

    let(:list_id) { list_1.id }

    context 'for existing list id' do
      it 'has no_content http status' do
        subject
        expect(response).to have_http_status(:no_content)
      end

      it 'does changes lists count in db by -1' do
        expect { subject }.to change(List, :count).by(-1)
      end
    end

    context 'for NOT existing list id' do
      let(:list_id) { list_1.id + 123 }

      it_behaves_like 'json response', :not_found do
        before { subject }
      end

      it 'does NOT change lists count in db' do
        expect { subject }.not_to change(List, :count)
      end
    end
  end
end
