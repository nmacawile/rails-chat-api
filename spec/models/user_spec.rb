require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of :first_name }
  it { is_expected.to validate_presence_of :last_name }
  
  describe "#name" do
    let(:first_name) { subject.first_name }
    let(:last_name) { subject.last_name }
    
    it "returns the full name" do
      expect(subject.name).to eq "#{first_name} #{last_name}"
    end
  end
  
  it do
    is_expected.to(
      have_many(:group_chats_created)
        .with_foreign_key(:creator_id)
        .dependent(:destroy))
  end
  
  it { is_expected.to have_many(:joins).dependent(:destroy) }
  it { is_expected.to have_many(:group_chats) }
  it { is_expected.to have_many(:chats) }
  it { is_expected.to have_many(:chat_messages) }
  
  it 'cleans up spaces before saving' do
    new_user = build(:user, first_name: "     Foo\n\n\n\nBar     ", last_name: "  Baz\n\n\n\n  ")
    new_user.save
    expect(new_user.name).to eq('Foo Bar Baz')
  end
end
