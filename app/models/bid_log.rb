class BidLog < ApplicationRecord
  belongs_to :user
  sync :all
  scope :get_highest_bid, lambda { |id| where(player_id: id).order('amount DESC').first }
end
