class ChatChannel < ApplicationCable::Channel
  def subscribed
    chat_user.chats.each do |chat|
      stream_for chat
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
