class CreateWickets < ActiveRecord::Migration
  def change
    create_table :wickets do |t|
      t.integer :batsman_id
      t.integer :bowler_id
      t.integer :ball_id
      t.integer :inning_id
      t.string :wicket_type
      t.integer :wicket_partner_id
      t.timestamps null: false
    end
  end
end
