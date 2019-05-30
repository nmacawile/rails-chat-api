require 'rails_helper'

RSpec.describe 'TokenValidation', type: :request do
  let(:user) { create :user }
  
  before do
    get '/auth/validate', headers: request_headers(user.id)
  end
  
  describe 'GET /auth/validate' do
    it 'returns the user attributes' do
      expect(json).to eq user_attributes(user)
    end
    
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end