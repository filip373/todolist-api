# frozen_string_literal: true

p 'Seed users'
3.times do |n|
  User.create!(
    oauth_id: Faker::Omniauth.google[:uid] + n.to_s,
    email: Faker::Internet.email + n.to_s
  )
end

p 'Seed notes'
20.times do
  Note.create!(
    title: Faker::Hipster.sentence[0...30],
    content: Faker::Hipster.paragraph(5, false, 5)[0...200]
  )
end

p 'Seed lists'
5.times do |n|
  List.create!(
    title: Faker::Hipster.sentence[0...30],
    deadline: (n > 2 ? Faker::Hipster.paragraph(5, false, 5)[0...200] : nil),
    user: User.order('RANDOM()').first
  )
end

p 'Assign notes to lists'
Note.first(15).each do |note|
  note.update! list: List.order('RANDOM()').first
end
