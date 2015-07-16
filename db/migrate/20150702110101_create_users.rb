class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.belongs_to :designation, index: true
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :email
      t.string :login_id
      t.string :password
      t.string :employee_id
      t.date :date_of_birth
      t.string :gender
      t.string :time_zone
      t.date :date_of_joining
      t.text :education
      t.text :comments
      t.boolean :is_locked
      t.boolean :is_active
      t.date :deactivated_on
      t.text :reason
      t.string :work_phone
      t.timestamps null: false
    end
  end
end
