class CreateOvers < ActiveRecord::Migration
  def change
    create_table :overs do |t|
      t.integer :bowler_id
      t.integer :inning_id
      t.integer :over_number
      t.integer :runs_scored
      t.string :status
      t.timestamps null: false
    end
  end
end
