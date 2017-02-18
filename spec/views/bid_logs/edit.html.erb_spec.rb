require 'rails_helper'

RSpec.describe "bid_logs/edit", type: :view do
  before(:each) do
    @bid_log = assign(:bid_log, BidLog.create!(
      :amount => 1,
      :user => nil
    ))
  end

  it "renders the edit bid_log form" do
    render

    assert_select "form[action=?][method=?]", bid_log_path(@bid_log), "post" do

      assert_select "input#bid_log_amount[name=?]", "bid_log[amount]"

      assert_select "input#bid_log_user_id[name=?]", "bid_log[user_id]"
    end
  end
end
