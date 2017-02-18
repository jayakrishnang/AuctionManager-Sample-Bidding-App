require 'rails_helper'

RSpec.describe "bid_logs/new", type: :view do
  before(:each) do
    assign(:bid_log, BidLog.new(
      :amount => 1,
      :user => nil
    ))
  end

  it "renders new bid_log form" do
    render

    assert_select "form[action=?][method=?]", bid_logs_path, "post" do

      assert_select "input#bid_log_amount[name=?]", "bid_log[amount]"

      assert_select "input#bid_log_user_id[name=?]", "bid_log[user_id]"
    end
  end
end
