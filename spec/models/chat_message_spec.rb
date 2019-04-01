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
  end
end
