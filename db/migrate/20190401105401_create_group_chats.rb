class CreateGroupChats < ActiveRecord::Migration[5.2]
  def change
    create_table :group_chats do |t|
      t.references :creator, foreign_key: { to_table: :users }
      t.string :name, null: false, default: ""
      
      t.timestamps
    end
  end
end
