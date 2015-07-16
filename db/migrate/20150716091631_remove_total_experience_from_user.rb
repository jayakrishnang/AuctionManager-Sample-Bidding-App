class RemoveTotalExperienceFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :total_experience, :float
  end
end
