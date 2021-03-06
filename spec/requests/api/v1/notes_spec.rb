# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API::V1::Notes', type: :request do
  include_context 'created auth user'
  let(:note_1) { create :note, title: 'first title', content: 'first' }
  let(:note_2) { create :note, title: 'second title', content: 'second' }
  let(:parsed_response) { JSON.parse response.body }

  describe 'GET /api/v1/notes' do
    before do
      note_1
      note_2
    end
    before do
      VCR.use_cassette('auth0_jwks') do
        auth_get api_v1_notes_path
      end
    end

    it_behaves_like 'json response', :ok

    it 'contains created notes' do
      first = Note.new parsed_response[0]
      second = Note.new parsed_response[1]
      expect(first).to eq(note_1)
      expect(second).to eq(note_2)
    end
  end

  describe 'GET /api/v1/notes/:id' do
    before do
      VCR.use_cassette('auth0_jwks') do
        auth_get api_v1_note_path(note_1.id)
      end
    end

    it_behaves_like 'json response', :ok

    it 'contains created note' do
      retrieved = Note.new parsed_response
      expect(retrieved).to eq(note_1)
    end
  end

  describe 'POST /api/v1/notes' do
    subject do
      VCR.use_cassette('auth0_jwks') do
        auth_post api_v1_notes_path(note_params)
      end
    end

    let(:note_params) do
      {
        note: {
          title: title,
          content: 'test content'
        }
      }
    end

    context 'for valid note params' do
      let(:title) { 'some title' }

      it_behaves_like 'json response', :created do
        before { subject }
      end

      it 'changes notes count in db by 1' do
        expect { subject }.to(change { Note.count }.by(1))
      end
    end

    context 'for invalid note params' do
      let(:title) { '' }

      it_behaves_like 'json response', :unprocessable_entity do
        before { subject }
      end

      it 'does NOT change notes count in db' do
        expect { subject }.not_to(change { Note.count })
      end
    end
  end

  describe 'PUT /api/v1/notes/:id' do
    before { note_1 }
    subject do
      VCR.use_cassette('auth0_jwks') do
        auth_put api_v1_note_path(note_params)
      end
    end

    let(:note_params) do
      {
        id: note_id,
        note: {
          title: title,
          content: 'some content'
        }
      }
    end
    let(:title) { 'some valid title' }
    let(:note_id) { note_1.id }

    context 'for valid note params' do
      it_behaves_like 'json response', :ok do
        before { subject }
      end

      it 'does NOT change notes count in db' do
        expect { subject }.not_to(change { Note.count })
      end
    end

    context 'for invalid note params' do
      let(:title) { '' }

      it_behaves_like 'json response', :unprocessable_entity do
        before { subject }
      end

      it 'does NOT change notes count in db' do
        expect { subject }.not_to(change { Note.count })
      end
    end

    context 'for NOT existing note id' do
      let(:note_id) { note_1.id + 123 }

      it_behaves_like 'json response', :not_found do
        before { subject }
      end

      it 'does NOT change notes count in db' do
        expect { subject }.not_to(change { Note.count })
      end
    end
  end

  describe 'DELETE /api/v1/notes/:id' do
    before { note_1 }
    subject do
      VCR.use_cassette('auth0_jwks') do
        auth_delete api_v1_note_path(note_id)
      end
    end

    let(:note_id) { note_1.id }

    context 'for existing note id' do
      it 'has no_content http status' do
        subject
        expect(response).to have_http_status(:no_content)
      end

      it 'does changes notes count in db by -1' do
        expect { subject }.to(change { Note.count }.by(-1))
      end
    end

    context 'for NOT existing note id' do
      let(:note_id) { note_1.id + 123 }

      it_behaves_like 'json response', :not_found do
        before { subject }
      end

      it 'does NOT change notes count in db' do
        expect { subject }.not_to(change { Note.count })
      end
    end
  end
end
