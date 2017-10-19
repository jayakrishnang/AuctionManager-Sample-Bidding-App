class Admin::InningsController < ApplicationController
	def show
		@inning = Inning.where(id: params[:id]).first
		@batsmen = @inning.team.users.where(is_batting: true)
		@striker = @batsmen.where(is_on_strike:true).first
		@non_striker = @batsmen.where(is_on_strike:false).first
		@bowler = Team.where(id: @inning.opponent_id).first.users.where(is_bowling: true).first
		@opponents = Team.where(id: @inning.opponent_id).first.users
		@opponent_inning = Inning.where(team_id: @inning.opponent_id, match_id: @inning.match_id).first
		@over = @inning.overs.last || Over.create(inning_id: @inning.id, bowler_id: @bowler.id, status: 'NEW')
	end

	def start_innings
		@inning = Inning.where(id: params[:inning_id]).first
		@batsmen = @inning.team.users
		@active_batsmen = @inning.team.users.where(is_batting: true)
		@bowlers = Team.where(id: @inning.opponent_id).first.users
		@active_bowler = Team.where(id: @inning.opponent_id).first.users.where(is_bowling: true).first
	end

	def create_ball_details
		@inning = Inning.where(id: params[:inning_id]).first
		@over = Over.where(id: params[:over_id]).first
		legitimacy = params[:extra_type].blank?
		@ball = Ball.create(over_id: @over.id, batsman_id: params[:batsman_id],
								runs_scored: params[:runs_scored], result: params[:result],
								extra_type: params[:extra_type], extra: params[:extra_runs],
								is_legitimate: legitimacy)
		if legitimacy
			@inning.overs_played = @inning.overs_played.to_f + 0.1
		end
		@inning.runs_scored = @inning.runs_scored.to_i + params[:runs_scored].to_i + params[:extra_runs].to_i
		@inning.save
		@over.update_status
		change_strike
		create_wickets
		update_innings
		if @inning.status == 'COMPLETED'
			redirect_to admin_match_path(@inning.match)
		elsif params[:wicket_type].present?
			redirect_to admin_inning_start_innings_path(@inning)
		else
			redirect_to admin_inning_path(@inning)
		end
	end

	def create_over
		inning = Inning.where(id: params[:inning_id]).first
		bowler = User.where(id: params[:bowler_id]).first
		over_count = inning.overs.count
		Over.create(inning_id: params[:inning_id], bowler_id: params[:bowler_id], status: 'NEW', over_number: over_count+1)
		bowler.update_attributes(is_bowling: true)
		redirect_to admin_inning_path(inning)
	end

	def proceed_innings
		inning = Inning.where(id: params[:inning_id]).first
		batsman_1 = User.where(id: params[:batsman_1]).first
		batsman_2 = User.where(id: params[:batsman_2]).first
		bowler = User.where(id: params[:bowler_id]).first
		if inning.status == 'NEW'
			Over.create(inning_id: params[:inning_id], bowler_id: params[:bowler_id], status: 'NEW', over_number: 1)
			batsman_1.update_attributes(is_batting:true, is_on_strike:true) if batsman_1.present?
			batsman_2.update_attributes(is_batting:true, is_on_strike:false) if batsman_2.present?
		else
			other_batsman = User.where(team_id: inning.team_id, is_batting:true).first
			batsman_1.update_attributes(is_batting:true) if batsman_1.present?
			batsman_2.update_attributes(is_batting:true, is_on_strike: !other_batsman.is_on_strike) if batsman_2.present?		
		end		
		bowler.update_attributes(is_bowling: true) if bowler.present?
		inning.update_attributes(status: 'ONGOING')
		inning.match.update_attributes(status: 'ONGOING')
		redirect_to admin_inning_path(inning)
	end

	def change_strike
		if [1,3].include?(params[:runs_scored].to_i) || 
			(['Leg Bye', 'Bye'].include?(params[:extra_type]) && [1,3].include?(params[:extra_runs].to_i)) ||
			(@over.over_ended?)
			striker = User.where(id: params[:batsman_id]).first
			non_striker = User.where(id: params[:non_striker_id]).first
			striker.update_attributes(is_on_strike: false)
			non_striker.update_attributes(is_on_strike: true)
		end
	end

	def update_innings
		@opponent_inning = Inning.where(team_id: @inning.opponent_id, match_id: @inning.match_id).first
		if @inning.status == 'ONGOING' && ((@over.over_number == 8 && @over.over_ended?) ||
				@inning.wickets.count == 10 ||
				(@opponent_inning.status == 'COMPLETED' && @inning.runs_scored > @opponent_inning.runs_scored))
			@inning.update_attributes(status: 'COMPLETED')
			match = @inning.match
			User.where(team_id: @inning.team_id, is_batting: true).update_all(is_batting:false, is_on_strike:false)
			both_innings = match.innings
			if both_innings.map(&:status) == ['COMPLETED','COMPLETED']
				if both_innings.first.runs_scored > both_innings.last.runs_scored
					match.update_attributes(winner_id: both_innings.first.team_id, status:'COMPLETED')
				elsif both_innings.first.runs_scored < both_innings.last.runs_scored
					match.update_attributes(winner_id: both_innings.last.team_id, status:'COMPLETED')
				end
			end
		end
	end

	def create_wickets
		if params[:wicket_type].present?
			wicket = Wicket.create(batsman_id: params[:wicket_batsman], wicket_type: params[:wicket_type],
										bowler_id: @over.bowler_id, ball_id: @ball.id, inning_id: @inning.id,
										wicket_partner_id: params[:wicket_partner])
			@ball.update_attributes(wicket_id: wicket.id)
			batsman = User.where(id: params[:wicket_batsman]).first
			strike_retain = batsman.is_on_strike
			batsman.update_attributes(is_batting: false, is_on_strike:false)
			unless strike_retain
				other_batsman = User.where(team_id: @inning.team_id, is_batting:true).first
				other_batsman.update_attributes(is_on_strike: true) if other_batsman.present?
			end
			@inning.update_attributes(status: 'COMPLETED') if @inning.wickets.count == 10
		end
	end

	def switch_strike
		inning = Inning.where(id: params[:inning_id]).first
		batsmen = User.where(team_id: inning.team_id, is_batting:true)
		batsmen.first.update_attributes(is_on_strike: !batsmen.first.is_on_strike)
		batsmen.last.update_attributes(is_on_strike: !batsmen.last.is_on_strike)
		redirect_to admin_inning_path(inning)
	end

	def scoreboard
		@inning = Inning.where(id: params[:inning_id]).first
		@batsmen = User.where(team_id: @inning.team_id)
		@batsmen = @batsmen.sort_by{|b| b.crease_arrival_order(@inning.id)}
	end
end
