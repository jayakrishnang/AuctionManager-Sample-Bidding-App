class BidLog < ActiveRecord::Base
  belongs_to :user
  sync :all
  scope :get_highest_bid, lambda { |id| where(player_id: id).group('amount DESC').first }
end
