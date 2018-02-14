class AddIsOnStrikeUsers < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :is_on_strike, :boolean, default: false
  end
end
