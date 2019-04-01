FactoryBot.define do
  factory :chat_message do
    association(:user, factory: :user)
    content { Faker::Lorem.paragraph }
    
    trait :group_chat do
      association(:messageable, factory: :group_chat)
    end
    
    trait :chat do
      association(:messageable, factory: :chat)
    end
  end
end
