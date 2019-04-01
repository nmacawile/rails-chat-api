class Chat < ApplicationRecord
  has_many :joins, as: :joinable, dependent: :destroy
  has_many :users, through: :joins
  has_many :chat_messages, as: :messageable, dependent: :destroy
end
