class AuthenticateUser
  def initialize(email, password)
    @email = email
    @password = password
  end
  
  def call
    if user
      { 
        auth_token: JsonWebToken.encode({ user_id: user.id }),
        user: UserAttributes.json(user)
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
end