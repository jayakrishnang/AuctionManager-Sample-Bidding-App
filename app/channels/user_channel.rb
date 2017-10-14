class UserChannel < ApplicationCable::Channel
  def subscribed
    stream_from "user_channel_#{Date.today}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def call_bid(data)
  	current_user.bid_logs.create!(amount: data['amount'], player_id: data['player_id'], user_id: current_user.id)
  end
end
