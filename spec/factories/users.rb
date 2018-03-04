# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email 'test@user.test'
    oauth_id 'MyString'
  end
end
