require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let(:user) { build :user }
  let(:valid_attributes) do
    attributes_for :user, password: user.password,
                          password_confirmation: user.password
  end
  
  describe 'POST /signup' do
    context 'when valid request' do
      before { post '/signup', params: valid_attributes.to_json, headers: request_headers }
      
      it 'creates a user' do
        expect(response).to have_http_status 201
      end
      
      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
      
      it 'returns a success message' do
        expect(json['message']).to match(/Account created successfully/)
      end
    end
    
    context 'when invalid request' do
      before { post '/signup', params: {}, headers: request_headers }
      
      it 'does not create a user' do
        expect(response).to have_http_status 422
      end
      
      it 'returns failure message' do
        expect(json['message']).to match(/Validation failed/)
      end
    end
  end
  
  describe 'GET /users' do
    let(:users) { create_list(:user, 30, first_name: 'Baz', last_name: 'Biz') }
    
    context 'without a query parameter' do
      before { get '/users', headers: request_headers(users.first.id) }
      
      it 'returns a paginated list of users' do
        expect(json.count).to eq(20)
      end
      
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
    
    context 'with a query parameter' do
      before do
        create(:user, first_name: 'Foobar')
        get '/users', params: { q: 'Foobar' }, headers: request_headers(users.first.id)
      end
      
      it 'returns a paginated list of users' do
        expect(json.count).to eq(1)
      end
      
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end
end
