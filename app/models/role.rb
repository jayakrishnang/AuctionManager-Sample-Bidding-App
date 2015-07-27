class Role < ActiveRecord::Base
	has_many :users
	scope :role_list, -> {pluck(:name, :id)}
end
