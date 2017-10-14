class BidLogBroadcastJob < ApplicationJob
  queue_as :default

  def perform(bid_log)
    ActionCable.server.broadcast "user_channel_#{Date.today}", bid_log: render_bid_log(bid_log)
  end

  private

  def render_bid_log(bid_log)
    ApplicationController.renderer.render(partial: 'team_owner/bid_logs/bid_log', locals: {bid_log: bid_log})
  end
end
