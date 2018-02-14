class AddRclFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :base_points, :integer
    add_column :users, :sold_points, :integer
    add_column :users, :team_id, :integer
    add_column :users, :team_status, :string
  end
end
