class ChatsController < ApplicationController
  before_action :set_chat, only: :show
  before_action :restrict_chat_access, only: :show
  
  def index
    @chats = current_user.chats
    json_response @chats
  end
  
  def show
    json_response @chat
  end
  
  def create
    @chat = QueryChatBetweenUsers
      .new(current_user.id, params[:user_id]).call
    json_response @chat
  end
  
  private
  
  def set_chat
    @chat = Chat.find(params[:id])
  end
  
  def restrict_chat_access
    unless @chat.users.include?(current_user)
      raise ExceptionHandler::AccessDenied, 'Access denied'
    end
  end
end
