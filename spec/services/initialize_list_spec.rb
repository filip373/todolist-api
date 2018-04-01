# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InitializeList, type: :service do
  subject { described_class.new params: params, user: user }
  let(:params) do
    ActionController::Parameters.new(
      title: 'some title', deadline: deadline.to_s
    ).permit!
  end
  let(:deadline) { 5.days.since.round }
  let(:user) { build_stubbed :user }

  describe '#call' do
    let(:initialized_list) { subject.call }

    it 'initializes List with given attributes', :aggregate_faillures do
      expect(initialized_list.user).to eq(user)
      expect(initialized_list.title).to eq('some title')
      expect(initialized_list.deadline).to eq(deadline)
    end
  end
end
