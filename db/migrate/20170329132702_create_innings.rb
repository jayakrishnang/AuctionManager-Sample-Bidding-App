class CreateInnings < ActiveRecord::Migration
  def change
    create_table :innings do |t|
      t.integer :team_id
      t.integer :match_id
      t.integer :runs_scored
      t.decimal :overs_played
      t.string :status
      t.timestamps null: false
    end
  end
end
