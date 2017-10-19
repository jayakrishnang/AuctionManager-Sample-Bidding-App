class AddIsOnStrikeUsers < ActiveRecord::Migration
  def change
  	add_column :users, :is_on_strike, :boolean, default: false
  end
end
