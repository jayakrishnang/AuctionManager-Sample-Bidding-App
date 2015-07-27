FactoryGirl.define do 
	factory :user do |f| 
		f.first_name "Jacob" 
		f.last_name "Roy" 
		f.email "jacobroy@yahoo.com"
		f.login_id "jacobroy"
		f.password "password"
		f.password_confirmation "password"
		f.previous_experience 1.0
		f.date_of_joining '2014-07-27'
		f.status "Active"
		f.work_phone "180-111-222-3333"
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