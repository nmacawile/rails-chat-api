FactoryBot.define do
  factory :group_chat do
    association(:creator, factory: :user)
  end
end
