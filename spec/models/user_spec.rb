require 'spec_helper'
describe User do
	#it "gives total experience of a user"
  it "has a valid factory" do 
  	@user = FactoryGirl.create(:user)
  	expect(@user).to be_valid
  end
end