class AuthenticateUser
  def initialize(email, password)
    @email = email
    @password = password
  end
  
  def call
    if user
      { 
        auth_token: JsonWebToken.encode({ user_id: user.id }),
        user: user_attributes
      }
    end
  end
  
  private
  
  attr_reader :email, :password
  
  def user
    user = User.find_by_email(email)
    return user if user && user.valid_password?(password)
    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end
  
  def user_attributes
    { 
      id: user.id,
      email: user.email,
      name: user.name,
      first_name: user.first_name,
      last_name: user.last_name
    }
  end
end