class Admin::MatchesController < ApplicationController

	def index
		@matches = Match.all
	end

	def show
		@match = Match.where(id: params[:id]).first
		@innings = @match.innings
	end

	def new
		@match = Match.new
		@teams = Team.pluck(:name, :id)
	end

	def create
		match = Match.create(name: params[:match][:name],
												team_1_id: params[:match][:team_1_id],
												team_2_id: params[:match][:team_2_id],
												status: 'NEW')
		Inning.create(team_id: params[:match][:team_1_id],
									opponent_id: params[:match][:team_2_id],
									match_id: match.id,
									runs_scored: 0,
									overs_played: 0.0,
									status: 'NEW')
		Inning.create(team_id: params[:match][:team_2_id],
									opponent_id: params[:match][:team_1_id],
									match_id: match.id,
									runs_scored: 0,
									overs_played: 0.0,
									status: 'NEW')
		redirect_to admin_match_path(match)
	end

	def points_table
		@teams = Team.all
		@teams = @teams.sort_by(&:calculate_net_run_rate).reverse
	end
end
