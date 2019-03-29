FactoryBot.define do
  factory :todo do
    email { 'User@email.com' }
    password { 'password1234' }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end
end