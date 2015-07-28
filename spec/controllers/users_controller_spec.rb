require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
	before (:each) do
    @role = FactoryGirl.create(:role , :name => "admin")
    @designation = FactoryGirl.create(:designation , :designation_name => "Trainee")
    @user = FactoryGirl.create(:admin_user,:role => @role)
    sign_in @user
  end
 
  describe "GET #index" do
    it "renders index view" do
      get :index
      expect(response).to render_template("index")
    end

    it "assigns users" do 
      get :index
      expect(assigns(:users)).to eq([@user]) 
    end   
  end

  describe "GET #show" do 
    it "assigns requested user to @user" do 
      get :show, id: @user 
      expect(assigns(:user)).to eq(@user) 
    end 

    it "renders the #show view" do 
      get :show, id: @user
      expect(response).to render_template :show 
    end 
  end 
  describe "GET #new" do
    it "should create a new registration page" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe 'POST #create' do
    context 'with valid details' do
      it 'creates user' do
        post :create, user: FactoryGirl.attributes_for(:user,:role_id => @role,:designation_id => @designation) 
        @user = User.last 
        expect(response).to redirect_to [:admin,@user]
      end
    end
    context 'when form is invalid' do
      it 'renders the page with error' do
        post :create, user: FactoryGirl.attributes_for(:user,:first_name => "",:role_id => @role,:designation_id => @designation)  
        expect(response).to render_template("new")
      end
    end
  end
  
  describe "GET #delete" do
    it "redirects to admin  index" do 
     	delete :destroy, id: @user 
     	expect(response).to redirect_to admin_users_path
   	end
  end  	
end
