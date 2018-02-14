class RemoveTotalExperienceFromUser < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :total_experience, :float
  end
end
