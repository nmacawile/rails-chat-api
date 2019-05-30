require 'rails_helper'

RSpec.describe 'Visibility API', type: :request do
  describe 'PATCH /visibility' do
    let(:user) { create :user }
    
    context 'when valid request' do
      context 'setting to false' do
        before do
          patch '/visibility', params: { visible: 0 }.to_json,
                                  headers: request_headers(user.id)
        end
        
        it 'returns 204 status code' do
          expect(response).to have_http_status(204)
        end
        
        it 'updates the user\'s visibility to false' do
          user.reload
          expect(user.visible).to be false
        end
      end
      
      context 'setting to true' do
        let(:user) { create :user, visible: false }
        
        before do
          patch '/visibility', params: { visible: 1 }.to_json,
                                  headers: request_headers(user.id)
        end
        
        it 'returns 204 status code' do
          expect(response).to have_http_status(204)
        end
        
        it 'updates the user\'s visibility to true' do
          user.reload
          expect(user.visible).to be true
        end
      end
    end
    
    context 'when invalid request' do
      before do
        patch '/visibility', params: { visible: nil }.to_json,
                                headers: request_headers(user.id)
      end
      
      it 'returns 400 status code' do
        expect(response).to have_http_status(400)
      end
      
      it 'returns a BadRequest error message' do
        expect(json['message']).to match(/BadRequest/)
      end
    end
  end
end