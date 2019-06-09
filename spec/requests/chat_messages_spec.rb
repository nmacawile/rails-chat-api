require 'rails_helper'

RSpec.describe 'ChatMessages API', type: :request do
  let(:user1) { create :user }
  let(:user2) { create :user }
  let(:third_party) { create :user }
  let(:chat) { create :chat }
  let(:chat_id) { chat.id }
  
  before do
    create :join, joinable: chat, user: user1
    create :join, joinable: chat, user: user2
  end
  
  describe 'GET /chats/:chat_id/messages' do
    let!(:chat_messages) { create_list :chat_message, 50, messageable: chat, user: user1 }
    
    context 'when user belongs in the chat' do
      before do
        get "/chats/#{chat_id}/messages", headers: request_headers(user1.id)
      end
      
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
      
      it 'returns the paginated chat messages' do
        expect(json.size).to eq(20)
      end
    end
    
    context 'when user doesn\'t belong in the chat' do
      before do
        get "/chats/#{chat_id}/messages", headers: request_headers(third_party.id)
      end
      
      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end
      
      it 'returns an Unauthorized error message' do
        expect(json['message']).to match 'Access denied'
      end
    end
    
    context 'when querying messages created before a given message' do
      let(:latest_message_id) { chat_messages.last.id }
      
      before do
        get "/chats/#{chat_id}/messages", params: { before: latest_message_id },
                                          headers: request_headers(user1.id)
      end
      
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
      
      it 'returns the paginated messages' do
        expect(json.count).to eq(20)
      end
      
      it 'doesn\'t include the queried message in the results' do
        expect(json.first['id']).to be < latest_message_id
      end
    end
  end
  
  describe 'POST /chats/:chat_id/messages' do
    context 'when valid request' do
      before do
        post("/chats/#{chat_id}/messages", 
          params: { content: 'Hello world!!!' }.to_json,
          headers: request_headers(user1.id))
      end
      
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
    
    context 'when invalid request' do
      before do
        post("/chats/#{chat_id}/messages", 
          params: {},
          headers: request_headers(user1.id))
      end
      
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
      
      it 'returns an Unauthorized error message' do
        expect(json['message']).to match(/Validation failed/)
      end
    end
    
    context 'when user doesn\'t belong in the chat' do
      before do
        post("/chats/#{chat_id}/messages", 
          params: { content: 'Hello world!!!' }.to_json,
          headers: request_headers(third_party.id))
      end
      
      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end
      
      it 'returns an Unauthorized error message' do
        expect(json['message']).to match 'Access denied'
      end
    end
  end
end