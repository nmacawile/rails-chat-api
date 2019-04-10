module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :chat_user
    
    def connect
      self.chat_user = find_verified_user
    end
    
    private
    
    def find_verified_user
      (AuthorizeApiRequest.new(request.params).call)[:user]
    rescue
      reject_unauthorized_connection
    end
  end
end
