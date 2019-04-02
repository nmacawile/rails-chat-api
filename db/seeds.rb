10.times do |n|
  User.create!(first_name: Faker::Name.first_name,
               last_name: Faker::Name.last_name,
               email: "user#{n}@email.com",
               password: 'password1234')
end

c = Chat.create!

u1 = User.first
u2 = User.second

Join.create!(user: u1, joinable: c)
Join.create!(user: u2, joinable: c)

u1.chat_messages.create!(messageable: c, content: Faker::Lorem.paragraph)
u2.chat_messages.create!(messageable: c, content: Faker::Lorem.paragraph)


c2 = Chat.create!
u3 = User.find(3)
Join.create!(user: u1, joinable: c2)
Join.create!(user: u3, joinable: c2)