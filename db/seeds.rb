# frozen_string_literal: true

p 'Seed notes'
15.times do
  Note.create!(
    title: Faker::Hipster.sentence[0...30],
    content: Faker::Hipster.paragraph[0...50]
  )
end
