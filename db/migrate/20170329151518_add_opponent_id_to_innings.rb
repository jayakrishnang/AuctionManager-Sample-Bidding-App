class AddOpponentIdToInnings < ActiveRecord::Migration
  def change
    add_column :innings, :opponent_id, :integer
  end
end
