class AddOwnerIdToTeams < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :owner_id, :integer
  end
end
