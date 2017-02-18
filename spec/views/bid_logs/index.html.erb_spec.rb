require 'rails_helper'

RSpec.describe "bid_logs/index", type: :view do
  before(:each) do
    assign(:bid_logs, [
      BidLog.create!(
        :amount => 2,
        :user => nil
      ),
      BidLog.create!(
        :amount => 2,
        :user => nil
      )
    ])
  end

  it "renders a list of bid_logs" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
