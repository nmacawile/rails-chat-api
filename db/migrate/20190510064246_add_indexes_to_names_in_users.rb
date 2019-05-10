class AddIndexesToNamesInUsers < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :first_name
    add_index :users, :last_name
  end
end
