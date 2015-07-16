class RemoveRoleIdIdFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :role_id_id, :integer
  end
end
