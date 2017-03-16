class TeamOwner::UsersController < ApplicationController
	# load_and_authorize_resource except: [:create]
  def index
    @users = User.where(role_id: Role.get_user_role_id)
  end

  def show
    @user = User.find(params[:id])
    @team = Team.get_team(current_user.id).first
    @next_user = User.where('id > ? AND role_id = ?', params[:id], Role.get_user_role_id).limit(1).first
    @purse_balance = @team.total_purse - @team.purse_spent
    @no_of_players = User.where(team_id: @team.id).count
    @male_players = User.where(team_id: @team.id, gender:'MALE').count
    @female_players = User.where(team_id: @team.id, gender:'FEMALE').count
    if @user.team_status == 'UNSOLD'
      @bid_log = BidLog.new
    else
      @bid_log = BidLog.where(player_id: @user.id).order('amount DESC').limit(1).first
    end
    @new_bid_log = BidLog.new
  end

  def list_team_players
    team_id = current_user.team_id
    @players = User.where(team_id: team_id, role_id:  Role.get_user_role_id)
  end
end
