class BidLogsController < ApplicationController
  # before_action :authenticate_user!
   respond_to :html, :js

  def index
    @bid_logs = BidLog.all
    @new_bid = current_user.bid_logs.build
  end

  def create
    player = User.where(id: bid_log_params['player_id']).first
    if current_user.role.try(:name) == 'admin'
      player.sell_player
      @bid_log = BidLog.get_highest_bid(player.id)
      @bid_log.is_closed = true
    else
      @bid_log = current_user.bid_logs.build(bid_log_params)
      player.update_team_status
    end
      @bid_log.save
    respond_to do |format|
      if current_user.role.try(:name) == 'admin'
        format.html { redirect_to admin_user_path(@bid_log.player_id) }
      else
        format.html { redirect_to team_owner_user_path(@bid_log.player_id) }
      end
      format.json { head :no_content }
    end
  end

  private

  def bid_log_params
    params.require(:bid_log).permit(:amount, :player_id)
  end
end
 