class BidLog < ApplicationRecord
  belongs_to :user
  scope :get_highest_bid, lambda { |id| where(player_id: id).order('amount DESC').first }
  after_create_commit { BidLogBroadcastJob.perform_later(self) }
end
