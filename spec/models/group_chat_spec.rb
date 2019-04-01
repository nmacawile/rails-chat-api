require 'rails_helper'

RSpec.describe GroupChat, type: :model do
  it { is_expected.to belong_to(:creator) }
  it { is_expected.to have_many(:joins).dependent(:destroy) }
  it { is_expected.to have_many(:users) }
  it { is_expected.to have_many(:chat_messages).dependent(:destroy) }
end
