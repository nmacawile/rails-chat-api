require 'rails_helper'

RSpec.describe AuthenticateUser do
  let(:user) { create :user }
  let(:valid_auth_object) { described_class.new(user.email, user.password) }
  let(:invalid_auth_object) { described_class.new('invalid_user@email.com', 'foobar1234') }
  
  describe '#call' do
    context 'when valid credentials' do
      it 'returns an auth token' do
        token = valid_auth_object.call
        expect(token).not_to be_nil
      end
    end
    
    context 'when invalid credentials' do
      it 'returns an auth token' do
        token = valid_auth_object.call
        expect(token).not_to be_nil
      end
      
      it 'raises an authentication error' do
        expect { invalid_auth_object.call }
          .to raise_error(
            ExceptionHandler::AuthenticationError,
            /Invalid credentials/
          )
      end
    end
  end
end