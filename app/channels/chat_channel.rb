class ChatChannel < ApplicationCable::Channel
  def subscribed
    chat = chat_user.chats.find(params['chat_id'])
    stream_for chat
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
