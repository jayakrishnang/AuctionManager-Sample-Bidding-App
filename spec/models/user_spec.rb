require 'spec_helper'
describe User do
	# before(:user) do
 #    @thing = Thing.new
 #  end
	#it "gives total experience of a user"
  it "has a valid factory" do 
  	@user = FactoryGirl.create(:user)
  	expect(@user).to be_valid
  end
  context "calculate_total_experience" do
  	it "gives total experience" do
  	  @user = FactoryGirl.create(:user)

  	  expect(@total_experience = @user.calculate_total_experience).to eq(2.0)
  	end
  end

end