module ControllerSpecHelper
  def token_generator(user_id)
    JsonWebToken.encode(user_id: user_id)
  end
  
  def expired_token_generator(user_id)
    JsonWebToken.encode({ user_id: user_id }, 10.seconds.ago)
  end
  
  def request_headers(user_id = nil)
    headers = { 
      'Content-Type' => 'application/json',
      'Accept' => 'json'
    }
    headers['Authorization'] = token_generator(user_id) if user_id
    headers
  end
  
  def user_attributes(user)
    user.slice(:id, :name, :email, :first_name, :last_name, :visible)
  end
end