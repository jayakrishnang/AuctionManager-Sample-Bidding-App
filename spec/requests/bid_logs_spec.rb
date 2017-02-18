require 'rails_helper'

RSpec.describe "BidLogs", type: :request do
  describe "GET /bid_logs" do
    it "works! (now write some real specs)" do
      get bid_logs_path
      expect(response).to have_http_status(200)
    end
  end
end
