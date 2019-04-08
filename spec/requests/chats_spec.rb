require 'rails_helper'

RSpec.describe 'Chats API', type: :request do
  let(:user) { create :user }
  let(:user2) { create :user }
  let(:chat) do
    chat = create :chat
    create :join, joinable: chat, user: user
    create :join, joinable: chat, user: user2
    chat
  end
  let(:chat_id) { chat.id }
  let(:users) { create_list :user, 4 }
  
  before do
    users[0..1].each do |other_user|
      c = create :chat
      create :join, joinable: c, user: user
      create :join, joinable: c, user: other_user
      user.chat_messages
        .create!(messageable: c, content: Faker::Lorem.paragraph)
    end
    
    users[2..3].each do |other_user|
      c = create :chat
      create :join, joinable: c, user: user2
      create :join, joinable: c, user: other_user
      user2.chat_messages
        .create!(messageable: c, content: Faker::Lorem.paragraph)
    end
  end
  
  describe 'GET /chats' do
    before { get '/chats', headers: request_headers(user.id) }
  
    it 'returns all chats with messages linked to user' do
      expect(json.size).to eq(2)
    end
  
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
  
  describe 'GET /chats/:id' do
    context 'when chat exists' do
      before { get "/chats/#{chat_id}", headers: request_headers(user.id) }
      
      it 'returns the chat object' do
        expect(json['id']).to eq(chat.id)
      end
      
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
    
    context 'when chat doesn\'t exist' do
      let(:chat_id) { 0 }
      before { get "/chats/#{chat_id}", headers: request_headers(user.id) }
      
      it 'returns a NotFound error message' do
        expect(json['message']).to match(/Couldn't find Chat/)
      end
      
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
    
    context 'when user doesn\'t belong in the chat' do
      before { get "/chats/#{chat_id}", headers: request_headers(users[0].id) }
      
      it 'returns an AccessDenied message' do
        expect(json['message']).to match(/Access denied/)
      end
      
      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end
    end
  end
  
  describe 'POST /chats' do
    context 'when user exists (valid request)' do
      before do
        post '/chats', params: { user_id: users[3].id }.to_json,
                       headers: request_headers(user.id)
      end
      
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
    
    context 'when user doesn\'t exist (invalid request)' do
      before do
        post '/chats', params: { user_id: 0 }.to_json,
                       headers: request_headers(user.id)
      end
      
      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
      
      it 'returns a BadRequest error message' do
        expect(json['message']).to match 'Bad request'
      end
    end
    
    context 'when no parameter is given' do
      before do
        post '/chats', params: {},
                       headers: request_headers(user.id)
      end
      
      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
      
      it 'returns a BadRequest error message' do
        expect(json['message']).to match 'Bad request'
      end
    end
  end
end