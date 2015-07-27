FactoryGirl.define do 
	factory :role do
		name "user"
	end
	factory :admin, class: Role do 
		name "admin"
	end
end