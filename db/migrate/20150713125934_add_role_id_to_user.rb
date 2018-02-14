class AddRoleIdToUser < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :role, index: true, foreign_key: true
  end
end
