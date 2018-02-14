class AddPreviousExperienceToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :previous_experience, :float
    add_column :users, :total_experience, :float
  end
end
