# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SaveNewList, type: :service do
  subject { described_class.new list }
  let(:list) { build :list, title: title }

  before do
    allow(ListMailer).to receive(:new_list).and_return(stubbed_mailer)
  end
  let(:stubbed_mailer) { double deliver_later: nil }

  describe '#call' do
    context 'when it can be saved' do
      let(:title) { 'existing title' }

      it 'returns true' do
        expect(subject.call).to eq(true)
      end

      it 'saves list in the database' do
        subject.call
        expect(list).to be_persisted
      end

      it 'enqueues new list email' do
        expect(ListMailer).to receive(:new_list)
        expect(stubbed_mailer).to receive(:deliver_later)
        subject.call
      end
    end

    context 'when it cannot be saved' do
      let(:title) { nil }

      it 'returns false' do
        expect(subject.call).to eq(false)
      end

      it 'does NOT save list in the database' do
        subject.call
        expect(list).not_to be_persisted
      end

      it 'does NOT enqueue new list email' do
        expect(ListMailer).not_to receive(:new_list)
        subject.call
      end
    end
  end
end
