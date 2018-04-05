# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ListSerializer, type: :serializer do
  subject { described_class.new(list) }

  describe '#serializable_hash' do
    let(:list) do
      build :list, id: 987, title: 'some title', deadline: deadline
    end
    let(:deadline) { 1.day.since }

    it 'contains valid keys', :aggreagate_failures do
      expect(subject.serializable_hash.keys)
        .to contain_exactly(:id, :title, :deadline)
    end

    it 'contains valid values', :aggreagate_failures do
      hash = subject.serializable_hash
      expect(hash[:id]).to eq(987)
      expect(hash[:title]).to eq('some title')
      expect(hash[:deadline]).to eq(deadline)
    end
  end
end
