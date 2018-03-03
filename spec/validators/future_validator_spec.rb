# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FutureValidator, type: :validator do
  subject { validatable.new }
  let(:validatable) do
    Class.new(ValidatorHelper::Validatable) do
      attr_accessor :date
      validates :date, future: true
    end
  end
  before { subject.date = date }

  shared_examples 'is NOT valid' do
    it 'is invalid' do
      expect(subject).to be_invalid
    end

    it 'contains correct error message' do
      subject.valid?
      expect(subject.errors.messages[:date])
        .to contain_exactly('is not in the future')
    end
  end

  shared_examples 'is valid' do
    it 'is valid' do
      expect(subject).to be_valid
    end
  end

  context 'when date is nil' do
    let(:date) { nil }
    include_examples 'is valid'
  end

  context 'when date is the past' do
    let(:date) { 1.day.ago }
    include_examples 'is NOT valid'
  end

  context 'when date is the future' do
    let(:date) { 1.day.since }
    include_examples 'is valid'
  end

  context 'when date is at the current moment' do
    let(:date) { Time.parse '2017-04-12 2pm' }
    before { Timecop.freeze date }
    after { Timecop.return }
    include_examples 'is NOT valid'
  end
end
