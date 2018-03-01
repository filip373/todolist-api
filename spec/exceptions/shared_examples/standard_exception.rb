# frozen_string_literal: true

RSpec.shared_examples 'standard exception' do
  subject { described_class.new message }
  let(:message) { 'some test message' }

  it 'is kind of StandardError' do
    expect(subject).to be_kind_of(StandardError)
  end

  describe '#message' do
    it 'returns given message' do
      expect(subject.message).to eq('some test message')
    end
  end
end
