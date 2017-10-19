class CreateBalls < ActiveRecord::Migration
  def change
    create_table :balls do |t|
      t.integer :over_id
      t.integer :batsman_id
      t.integer :runs_scored
      t.string :result
      t.integer :extra
      t.string :extra_type
      t.integer :wicket_id
      t.boolean :is_legitimate
      t.timestamps null: false
    end
  end
end
