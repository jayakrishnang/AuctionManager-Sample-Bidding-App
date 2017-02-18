require "rails_helper"

RSpec.describe BidLogsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/bid_logs").to route_to("bid_logs#index")
    end

    it "routes to #new" do
      expect(:get => "/bid_logs/new").to route_to("bid_logs#new")
    end

    it "routes to #show" do
      expect(:get => "/bid_logs/1").to route_to("bid_logs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/bid_logs/1/edit").to route_to("bid_logs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/bid_logs").to route_to("bid_logs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/bid_logs/1").to route_to("bid_logs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/bid_logs/1").to route_to("bid_logs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/bid_logs/1").to route_to("bid_logs#destroy", :id => "1")
    end

  end
end
