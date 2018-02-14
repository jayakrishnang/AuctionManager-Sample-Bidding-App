class AddOpponentIdToInnings < ActiveRecord::Migration[5.1]
  def change
    add_column :innings, :opponent_id, :integer
  end
end
