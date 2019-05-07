class Chat < ApplicationRecord
  default_scope -> { order(updated_at: :desc) }
  scope :with_messages, -> { joins(:chat_messages).uniq }
  
  has_many :joins, as: :joinable, dependent: :destroy
  has_many :users, through: :joins
  has_many :chat_messages, as: :messageable, dependent: :destroy
  
  def latest_message
    chat_messages.first
  end
end
