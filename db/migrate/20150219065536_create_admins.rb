class CreateAdmins < ActiveRecord::Migration
	def change
		create_table :admins do |t|
			t.string :name
			t.integer :admin_id
			t.timestamps null: false
		end
	end
end
