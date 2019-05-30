class PresenceChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'presence'
    update_presence(chat_user, true)
  end

  def unsubscribed
    update_presence(chat_user, false)
  end
  
  private
  
  def update_presence(user, presence)
    user.update(present: presence)
    if user.visible
      ActionCable.server.broadcast(
        'presence', 
        { id: user.id, present: presence })
    end
  end
end
