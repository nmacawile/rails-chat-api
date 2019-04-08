class ChatsController < ApplicationController
  before_action :set_chat, only: :show
  before_action :restrict_chat_access, only: :show
  
  def index
    @chats = current_user.chats.with_messages
  end
  
  def show;end
  
  def create
    @chat = QueryChatBetweenUsers
      .new(current_user.id, params[:user_id]).call
    render :show
  end
  
  private
  
  def set_chat
    @chat = Chat.find(params[:id])
  end
end
