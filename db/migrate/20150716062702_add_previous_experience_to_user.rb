class AddPreviousExperienceToUser < ActiveRecord::Migration
  def change
    add_column :users, :previous_experience, :float
    add_column :users, :total_experience, :float
  end
end
