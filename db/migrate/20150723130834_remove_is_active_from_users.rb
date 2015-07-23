class RemoveIsActiveFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :is_active, :boolean
  end
end
