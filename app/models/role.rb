class Role < ActiveRecord::Base
	has_many :users

	def self.get_user_role_id
		where(name: 'user').first.try(:id)
	end
end
