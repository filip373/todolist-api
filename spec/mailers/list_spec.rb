# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ListMailer, type: :mailer do
  describe '#new_list' do
    subject { described_class.new_list(id) }

    context 'when list of given id exists' do
      let(:id) { list.id }
      let(:list) { create :list, user: user, title: 'Some test title' }
      let(:user) { create :user, email: 'test@email.test' }

      it 'delivers the email to the list owner' do
        expect(subject).to deliver_to('test@email.test')
      end

      it 'delivers the email from the correct address' do
        expect(subject).to deliver_from('mailer@todolist.test')
      end

      it 'has a correct subject' do
        expect(subject).to have_subject('Your new list has just been created')
      end

      it 'contains the list title' do
        expect(subject).to have_body_text('Some test title')
      end
    end

    context 'when list of given id does NOT exist' do
      let(:id) { 999 }

      it 'raises some error' do
        expect { subject.deliver_now }
          .to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
