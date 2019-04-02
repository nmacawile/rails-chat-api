class ChatsController < ApplicationController
  def index
    @chats = Chat.all
    json_response @chats
  end
end
