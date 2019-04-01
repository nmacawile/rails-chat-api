class CreateChatMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :chat_messages do |t|
      t.references :messageable, polymorphic: true
      t.references :user
      t.text :content

      t.timestamps
    end
  end
end
