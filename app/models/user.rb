class User < ApplicationRecord
  scope :excluding, -> (user) { where.not(id: user) }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :group_chats_created, class_name: 'GroupChat',
                                 foreign_key: :creator_id,
                                 dependent: :destroy
  
  has_many :joins, dependent: :destroy
  
  has_many :group_chats, through: :joins,
                         source: :joinable,
                         source_type: 'GroupChat'
                         
  has_many :chats, through: :joins,
                   source: :joinable,
                   source_type: 'Chat'
  
  has_many :chat_messages
  
  validates_presence_of :first_name, :last_name
  
  def name
    "#{first_name} #{last_name}"
  end
end
