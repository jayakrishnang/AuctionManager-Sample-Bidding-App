class Team < ApplicationRecord
	has_many :users
	has_many :innings
	scope :get_team, lambda { |id| where(owner_id: id) }
	scope :get_team_stats, -> { select('teams.*, COUNT(users.id) AS player_count')
																.joins('LEFT JOIN users ON users.team_id = teams.id')
																.group('teams.id')}
	def calculate_net_run_rate
		total_runs = self.innings.sum(:runs_scored)
		overs =  self.innings.map(&:overs_played)
		balls = 0
		overs.each do |over|
			balls += ((over.to_i * 6) + ((over.to_f * 10)%10))
		end
		if balls > 0
			(total_runs / balls).round(2)
		else
			0
		end
	end

	def matches
		Match.where("team_1_id = ? OR team_2_id = ?", id, id)
	end
end
