# frozen_string_literal: true

FactoryBot.define do
  factory :note do
    title 'Sample note title'
    content 'Some test note content'
    list nil
  end
end
