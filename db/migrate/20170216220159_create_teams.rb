class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :purse_spent
      t.integer :total_purse
    end
  end
end
