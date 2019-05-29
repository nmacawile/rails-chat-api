class AddPresentColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :present, :boolean, null: false, default: false
  end
end
