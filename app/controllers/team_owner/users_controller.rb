class TeamOwner::UsersController < ApplicationController
	# load_and_authorize_resource except: [:create]
  def index
    @users = User.where(role_id: Role.get_user_role_id)
  end

  def show
    @user = User.find(params[:id])
    @next_user = User.where('id > ? AND role_id = ?', params[:id], Role.get_user_role_id).limit(1).first
    if @user.team_status == 'UNSOLD'
      @bid_log = BidLog.new
    else
      @bid_log = BidLog.last
    end
    @new_bid_log = BidLog.new
  end
end
