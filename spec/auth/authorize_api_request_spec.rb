RSpec.describe AuthorizeApiRequest do
  let(:user) { create :user }
  let(:headers) { { 'Authorization' => token_generator(user.id) } }
  let(:invalid_headers) { { 'Authorization' => token_generator(100) } }
  subject(:request_object) { described_class.new(headers) }
  subject(:invalid_request_object) { described_class.new(invalid_headers) }
  
  describe '#call' do
    context 'when valid request' do
      it 'returns the user object' do
        result = request_object.call
        expect(result[:user]).to eq(user)
      end
    end
    
    context 'when expired token' do
      subject(:headers) do 
        { 'Authorization' => expired_token_generator(user.id) }
      end
      
      it 'raises an ExpiredToken error' do
        expect { request_object.call }
          .to raise_error(ExceptionHandler::InvalidToken, 'Signature has expired')
      end
    end
    
    context 'when invalid request' do
      it 'raises an InvalidToken error' do
        expect { invalid_request_object.call }
          .to raise_error(ExceptionHandler::InvalidToken, /Invalid token/)
      end
    end
    
    context 'when fake token' do
      let(:invalid_headers) { { 'Authorization' => 'foobar' } }
      
      it 'raises a InvalidToken error' do
        expect { invalid_request_object.call }
          .to raise_error(ExceptionHandler::InvalidToken, 'Not enough or too many segments')
      end
    end
    
    context 'when missing token' do
      subject(:invalid_request_object) { described_class.new({}) }
      
      it 'raises a MissingToken error' do
        expect { invalid_request_object.call }
          .to raise_error(ExceptionHandler::MissingToken, 'Missing token')
      end
    end
  end
end