class PresenceChannel < ApplicationCable::Channel
  def subscribed
    chat_user.update(present: true)
    stream_from 'presence'
    ActionCable.server.broadcast('presence', { id: chat_user.id, present: true })
  end

  def unsubscribed
    chat_user.update(present: false)
    ActionCable.server.broadcast('presence', { id: chat_user.id, present: false })
  end
end
