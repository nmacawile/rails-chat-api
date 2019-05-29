class ChatMessagesController < ApplicationController
  before_action :set_chat, only: [:index, :create]
  before_action :restrict_chat_access, only: [:index, :create]
  after_action :broadcast_message, only: :create
  
  def index
    @messages = @chat.chat_messages.page(params[:page]).per(20)
  end
  
  def create
    @chat_message = @chat.chat_messages
      .create!(
        user: current_user,
        content: params[:content])
    head :no_content
  end
  
  private
  
  def set_chat
    @chat = Chat.find(params[:chat_id])
  end
  
  def broadcast_message
    ChatChannel.broadcast_to(
      @chat,
      render_to_string(:show, format: :json))
      
    user_a, user_b = @chat.users
    notify_user(user_a, user_b)
    notify_user(user_b, user_a)
  end
  
  def notify_user(notifiable, other_user)
    NotificationsChannel.broadcast_to(
      notifiable,
      render_to_string('chats/notification', format: :json, locals: { other_user: other_user }))
  end
end
