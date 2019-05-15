class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create
  
  def index
    @users = QueryUsers
               .new(params[:q]).call
               .excluding(current_user)
               .page(params[:page]).per(10)
  end
  
  def create
    @user = User.create!(user_params)
    auth_info = AuthenticateUser.new(@user.email, @user.password).call
    auth_info[:message] = Message.account_created
    json_response(auth_info, :created)
  end
  
  private
  
  def user_params
    params.permit(:email, :password, :password_confirmation, :first_name, :last_name)
  end
end
