class CreateMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
    	t.string :name
      t.integer :team_1_id
      t.integer :team_2_id
      t.integer :toss_winner_id
      t.integer :winner_id
      t.string :status
      t.timestamps null: false
    end
  end
end
