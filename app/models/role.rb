class Role < ActiveRecord::Base
	has_many :users

	def self.get_user_role_id
		where(name: 'user').first.try(:id)
	end

	def self.get_admin_role_id
		where(name: 'admin').first.try(:id)
	end
end
