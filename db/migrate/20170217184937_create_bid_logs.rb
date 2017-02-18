class CreateBidLogs < ActiveRecord::Migration
  def change
    create_table :bid_logs do |t|
      t.integer :amount
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
