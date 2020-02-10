class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  
  before_action :authorize_request
  attr_reader :current_user
  helper_method :current_user
  
  def authorize_request
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end
  
  protected
  
  def restrict_chat_access
    unless @chat.users.include?(current_user)
      raise ExceptionHandler::AccessDenied, Message.access_denied
    end
  end
end
