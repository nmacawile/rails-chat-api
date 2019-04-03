class QueryChatBetweenUsers
  def initialize(user1, user2)
    @users = [user1, user2]
  end
  
  def call
    query = Chat
     .joins('JOIN "joins" AS "j1"'\
            'ON "j1"."joinable_id" = "chats"."id"'\
            'AND "j1"."joinable_type" = \'Chat\'')
     .joins('JOIN "joins" AS "j2"'\
            'ON "j2"."joinable_id" = "chats"."id"'\
            'AND "j2"."joinable_type" = \'Chat\'')
     .where('"j1"."user_id" <> "j2"."user_id"'\
            'AND "j1"."user_id" = ? AND "j2"."user_id" = ?', *users)
     .first
    query || create_chat_room 
  end
  
  private
  
  attr_reader :users
  
  def create_chat_room
    users_ = User.where(id: users)
    if users_.size == 2
      return Chat.create!(users: users_ )
    end
    raise ExceptionHandler::BadRequest, Message.bad_request
  end
end