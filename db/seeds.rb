admin_role = Role.find_or_create_by(name: 'admin')
user_role = Role.find_or_create_by(name: 'user')
team_owner_role = Role.find_or_create_by(name: 'team_owner')

seed_file = Rails.root.join('db', 'seeds', 'users.yml')
users = YAML::load_file(seed_file)
users.each do |user|
	user['email'] = "#{user['first_name']}#{user['last_name']}@rubyians.com".gsub(' ', '').downcase
	user['login_id'] = "#{user['first_name']}#{user['last_name']}".gsub(' ', '').downcase
	user['role_id'] = team_owner_role.id if user['role'] == 'team_owner'
	user['role_id'] = user_role.id if user['role'] == 'user'
	user.delete('role')
	User.create(user)
end

