class AddPlayerIdToBidLogs < ActiveRecord::Migration
  def change
  	 add_column :bid_logs, :player_id, :integer
  end
end
