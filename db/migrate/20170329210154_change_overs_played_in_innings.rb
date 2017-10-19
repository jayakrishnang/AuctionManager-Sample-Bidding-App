class ChangeOversPlayedInInnings < ActiveRecord::Migration
  def change
  	change_column :innings, :overs_played, :decimal, :precision => 10, :scale => 1
  end
end
