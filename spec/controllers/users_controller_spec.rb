require 'spec_helper'
RSpec.describe Admin::UsersController do
	before(:each) do
		@role = FactoryGirl.create(:role,:name => "admin")
		@user = FactoryGirl.create(:user,:role => @role)
		sign_in @user
	end
	describe "GET index" do
    it "renders the index view" do
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
  describe "GET #edit" do
  	it "edits the requested user" do
  		get :edit, id: @user
  		expect(assigns(:user)).to eq(@user)
  	end
  	it "renders the #edit view" do
  		get :edit, id: @user
  		expect(response).to render_template :edit
  	end
  end
  describe "POST create" do
  	context "with valid attributes" do
  		it "creates a new user" do
  			post :create, user: FactoryGirl.attributes_for(:user)
  			expect(@user).to eq(User.last)
   			expect(response.status).to eq(200)
  		end
  		it "redirects to the user details after creation" do
  			post :create, user: FactoryGirl.attributes_for(:user)
  			expect(@user).to be_valid
   			expect(response.status).to eq(200)
  			expect(response).to render_template :new
  		end
  	end
  	context "with invalid attributes" do
  		it "does not save the new user" do
  			expect{
  				post :create, user: FactoryGirl.attributes_for(:user, first_name: '')
  			}.to_not change(User,:count)
  		end
  		it "renders the new method again" do
  			post :create, user: FactoryGirl.attributes_for(:user, first_name: '')
  			expect(response).to render_template :new
 			end
 		end
 	end
end
