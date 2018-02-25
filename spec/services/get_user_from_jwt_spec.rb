# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GetUserFromJWT, type: :service do
  subject { described_class.new(jwt) }

  describe '#call' do
    context 'when JWT is nil' do
      let(:jwt) { nil }

      it 'raises error' do
        expect { subject.call }.to raise_error('Invalid token object')
      end
    end

    context 'when JWT is String' do
      let(:jwt) { 'something' }

      it 'raises error' do
        expect { subject.call }.to raise_error('Invalid token object')
      end
    end

    context 'when JWT is Hash' do
      context 'and does NOT contain sub key' do
        let(:jwt) { { something: 'test' } }

        it 'raises error' do
          expect(subject.call).to be_nil
        end
      end

      context 'and contains sub key' do
        let(:jwt) { { 'sub' => 'test-id-123' } }

        context 'and there exists a user with this id' do
          let!(:user) { create :user, oauth_id: 'test-id-123' }

          it 'returns user of given id' do
            expect(subject.call).to eq(user)
          end
        end

        context 'and there does NOT exist a user with this id' do
          before { create :user, oauth_id: 'test-id-987' }

          it 'raises error' do
            expect(subject.call).to be_nil
          end
        end
      end
    end
  end
end
