class AddPlayingInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_bowling, :boolean
    add_column :users, :is_batting, :boolean
  end
end
