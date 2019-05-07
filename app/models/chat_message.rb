class ChatMessage < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  
  before_save do
    self.content = content.strip.gsub(/\R{2,}/, "\r\n\r\n").gsub(/\R/, "\r\n")
  end
  
  belongs_to :messageable, polymorphic: true, touch: true
  belongs_to :user
  
  validates_presence_of :content
  validates_length_of :content, maximum: 2000
  
  def content_preview
    content.truncate(50, separator: /\s/)
  end
end
