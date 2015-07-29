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
	factory :admin_user, class: User do 
	 	first_name "Mathew" 
	 	last_name "Thomas" 
	 	email "mathewthomas@gmail.com"
	 	login_id "mathewthomas"
	 	password "password"
	 	password_confirmation "password"
	 	previous_experience 2.0
	 	status "Active"
		date_of_joining '2014-07-27'
	 	work_phone "180-111-222-3333"
  end
end