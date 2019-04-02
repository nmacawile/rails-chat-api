class AddUniqueCompoundIndexToJoins < ActiveRecord::Migration[5.2]
  def change
    add_index :joins, [:user_id, :joinable_type, :joinable_id], unique: true
  end
end
