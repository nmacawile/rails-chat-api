require 'rails_helper'

RSpec.describe ChatMessage, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:messageable) }
  it { is_expected.to validate_presence_of :content }
  it { is_expected.to validate_length_of(:content).is_at_most(2000) }
  
  describe 'orphaned by user' do
    subject { create(:chat_message, :chat) }
    let(:user) { subject.user }
    
    before { user.destroy }
    
    it 'doesn\'t get deleted' do
      is_expected.not_to be_nil
    end
    
    it 'does not have a user' do
      expect(user.persisted?).to be false
    end
    
    it 'cleans up line breaks and spaces before saving' do
      new_message = 
        build(:chat_message, :chat, content: "\n\n\nHello\n\n\n\nWorld!\n\n\n");
      new_message.save
      expect(new_message.content).to match(/Hello\R{2}World/)
    end
  end
end
