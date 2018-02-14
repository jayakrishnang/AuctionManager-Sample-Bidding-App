class ChangeOversPlayedInInnings < ActiveRecord::Migration[5.1]
  def change
  	change_column :innings, :overs_played, :decimal, :precision => 10, :scale => 1
  end
end
