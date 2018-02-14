class AddIsClosedToBidLogs < ActiveRecord::Migration[5.1]
  def change
    add_column :bid_logs, :is_closed, :boolean
  end
end
