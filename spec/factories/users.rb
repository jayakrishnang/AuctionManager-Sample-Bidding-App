FactoryGirl.define do 
	factory :user do 
		association :role
		first_name "Jacob" 
		last_name "Roy" 
		email "jacobroy@yahoo.com"
		login_id "jacobroy"
		password "password"
		password_confirmation "password"
		previous_experience 1.0
		date_of_joining '2014-07-27'
		work_phone "180-111-222-3333"
		trait :active do
			status 'Active'
		end
	  trait :locked do
		  	status "Locked"
	  end
  end 
	# factory :Lockeduser do |f| 
	# 	f.first_name "Mathew" 
	# 	f.last_name "Thomas" 
	# 	f.email "mathewthomas@yahoo.com"
	# 	f.login_id "mathewthomas"
	# 	f.password "password"
	# 	f.password_confirmation "password"
	# 	f.previous_experience 2.0
	# 	f.status "Locked"
	# 	f.date_of_joining Time.now
	# 	f.work_phone "180-111-222-3333"
	# end
end