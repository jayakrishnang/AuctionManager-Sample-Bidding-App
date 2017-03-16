class Team < ActiveRecord::Base
	has_many :users
	scope :get_team, lambda { |id| where(owner_id: id) }
	scope :get_team_stats, -> { select('teams.*, COUNT(users.id) AS player_count')
																.joins('LEFT JOIN users ON users.team_id = teams.id')
																.group('teams.id')}
end
