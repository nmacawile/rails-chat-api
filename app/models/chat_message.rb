class ChatMessage < ApplicationRecord
  belongs_to :messageable, polymorphic: true
  belongs_to :user
  
  validates_presence_of :content
  validates_length_of :content, maximum: 2000
end
