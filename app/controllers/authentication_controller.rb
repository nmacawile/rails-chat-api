class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate
  
  def authenticate
    auth_info =
      AuthenticateUser.new(
        params[:email],
        params[:password]
      ).call
      
    json_response(auth_info)
  end
end
