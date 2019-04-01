u = User.create!(first_name: Faker::Name.first_name,
                 last_name: Faker::Name.last_name,
                 email: 'test@email.com',
                 password: 'password1234')

c = Chat.create!

Join.create!(user: u, joinable: c)

m = u.chat_messages.create!(messageable: c, content: Faker::Lorem.paragraph)