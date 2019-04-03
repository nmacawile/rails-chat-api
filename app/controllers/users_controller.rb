class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create
  
  def create
    @user = User.create!(user_params)
    auth_token = AuthenticateUser.new(@user.email, @user.password).call
    response = { auth_token: auth_token, message: Message.account_created }
    json_response(response, :created)
  end
  
  private
  
  def user_params
    params.permit(:email, :password, :password_confirmation, :first_name, :last_name)
  end
end
