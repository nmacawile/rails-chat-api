class AddVisibleColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :visible, :boolean, null: false, default: true
  end
end
