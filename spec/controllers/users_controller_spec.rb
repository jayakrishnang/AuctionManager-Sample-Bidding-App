require 'spec_helper'
RSpec.describe Admin::UsersController do
	before(:each) do
		@role = FactoryGirl.create(:role,:name => "admin")
		@user = FactoryGirl.create(:user, :role => @role)
		sign_in @user
	end
	describe "GET index" do
    it "renders the :index view" do
    	get :index
    	expect(response).to render_template :index
    end
  end
  describe "GET #show" do
  	it "assigns the requested user to @user" do
  		get :show, id: @user
  		expect(assigns(:user)).to eq(@user)
  	end
  	it "renders the #show view" do
  		get :show, id: @user
  		expect(response).to render_template :show
  	end
  end
end