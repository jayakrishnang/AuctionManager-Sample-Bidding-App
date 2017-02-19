class AddIsClosedToBidLogs < ActiveRecord::Migration
  def change
    add_column :bid_logs, :is_closed, :boolean
  end
end
