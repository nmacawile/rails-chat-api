class ChatMessagesController < ApplicationController
  before_action :set_chat, only: [:index, :create]
  before_action :restrict_chat_access, only: [:index, :create]
  
  def index
    @messages = @chat.chat_messages.page(params[:page]).per(20)
  end
  
  def create
    @chat_message = @chat.chat_messages
      .create!(
        user: current_user,
        content: params[:content])
    ChatChannel.broadcast_to @chat, render_to_string(:show, format: :json)
    render :show, status: :created
  end
  
  private
  
  def set_chat
    @chat = Chat.find(params[:chat_id])
  end
end
