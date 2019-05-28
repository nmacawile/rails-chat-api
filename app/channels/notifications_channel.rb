class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_for chat_user
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
