# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@email.test" }
    sequence(:oauth_id) { |n| "a10#{n}" }
  end
end
