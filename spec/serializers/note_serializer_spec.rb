# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NoteSerializer, type: :serializer do
  subject { described_class.new(note) }

  describe '#serializable_hash' do
    let(:note) do
      build :note,
            id: 987,
            title: 'some title',
            content: 'some content',
            list: list
    end
    let(:list) { build :list }

    it 'contains valid keys', :aggreagate_failures do
      expect(subject.serializable_hash.keys)
        .to contain_exactly(:id, :title, :content, :list_id)
    end

    it 'contains valid values', :aggreagate_failures do
      hash = subject.serializable_hash
      expect(hash[:id]).to eq(987)
      expect(hash[:title]).to eq('some title')
      expect(hash[:content]).to eq('some content')
      expect(hash[:list_id]).to eq(list.id)
    end
  end
end
