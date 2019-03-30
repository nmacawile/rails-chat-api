class AuthenticationController < ApplicationController
  def authenticate
    auth_token =
      AuthenticateUser.new(
        params[:email],
        params[:password]
      ).call
      
    json_response(auth_token: auth_token)
  end
end
