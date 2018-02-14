class CreateDesignations < ActiveRecord::Migration[5.1]
  def change
    create_table :designations do |t|
      t.string :designation_name
      t.timestamps null: false
    end
  end
end
