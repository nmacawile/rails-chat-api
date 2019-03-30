class AuthenticateUser
  def initialize(email, password)
    @email = email
    @password = password
  end
  
  def call
    JsonWebToken.encode({ user_id: user.id }) if user
  end
  
  private
  
  attr_reader :email, :password
  
  def user
    user = User.find_by_email(email)
    return user if user && user.valid_password?(password)
    raise(ExceptionHandler::AuthenticationError, 'Invalid credentials')
  end
end