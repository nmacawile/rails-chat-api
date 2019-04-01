FactoryBot.define do
  factory :join do
    association(:user, factory: :user)
    
    trait :chat do
      association(:joinable, factory: :chat)
    end
    
    trait :group_chat do
      association(:joinable, factory: :group_chat)
    end
  end
end
