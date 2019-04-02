require 'rails_helper'

RSpec.describe Join, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:joinable) }
  
  describe 'joining a chat' do
    let(:user) { create :user }
    let(:chat) { create :chat }
    let(:join_chat) { create :join, joinable: chat, user: user }
    
    context 'when user has not yet joined the chat' do
      it 'joins the chat' do
        expect { join_chat }
          .to change { chat.users.count }.by(1)
      end
    end
    
    context 'when user has already joined the chat' do
      before do
        create :join, joinable: chat, user: user
      end

      it 'throws an error' do
        expect { join_chat }
          .to raise_error(ActiveRecord::RecordNotUnique)
      end
    end
  end
end
