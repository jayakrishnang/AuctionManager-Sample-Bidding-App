require 'rails_helper'

RSpec.describe "bid_logs/show", type: :view do
  before(:each) do
    @bid_log = assign(:bid_log, BidLog.create!(
      :amount => 2,
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(//)
  end
end
