class AddPlayerIdToBidLogs < ActiveRecord::Migration[5.1]
  def change
  	 add_column :bid_logs, :player_id, :integer
  end
end
