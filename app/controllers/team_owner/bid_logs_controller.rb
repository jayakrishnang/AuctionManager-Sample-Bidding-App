class BidLogsController < ApplicationController
  # before_action :authenticate_user!
   respond_to :html, :js

  def index
    @bid_logs = BidLog.all
    @new_bid = current_user.bid_logs.build
  end

  def create
    @bid_log = current_user.bid_logs.build(bid_log_params)
    
    if @bid_log.save
      sync_new @bid_log
    end
    respond_to do |format|
      format.html { redirect_to team_owner_user_path(@bid_log.player_id) }
      format.json { head :no_content }
    end
  end

  private

  def bid_log_params
    params.require(:bid_log).permit(:amount, :player_id)
  end
end
