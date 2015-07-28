require 'spec_helper'

describe User do
	before(:each) do
	  @user = FactoryGirl.create(:user, :active)
  end
	#it "gives total experience of a user"
  it "is valid" do 
  	expect(@user).to be_valid
  end
  it "is active" do
  	@active_user = FactoryGirl.build(:user, :active)
  	expect(@active_user.status).to eq('Active')
  end
  it "is locked" do
  	@locked_user = FactoryGirl.build(:user, :locked)
  	expect(@locked_user.status).to eq('Locked')
  end
  context "calculate_total_experience" do
  	it "gives total experience" do
  	  expect(@user.calculate_total_experience).to eq(2.0)
  	end
  end
end