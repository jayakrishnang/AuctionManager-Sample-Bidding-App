class UserChannel < ApplicationCable::Channel
  def subscribed
    stream_from "user_channel_#{Date.today}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def call_bid(data)
    player = User.where(id: data['player_id']).first
    if current_user.role.try(:name) == 'admin'
      player.sell_player
      @bid_log = BidLog.get_highest_bid(player.id)
      @bid_log.is_closed = true
    else
      @bid_log = current_user.bid_logs.build(amount: data['amount'], player_id: data['player_id'], user_id: current_user.id)
      player.update_team_status
    end
      @bid_log.save
  end

end
