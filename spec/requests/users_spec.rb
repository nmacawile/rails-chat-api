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
end
