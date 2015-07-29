require 'rails_helper'
RSpec.describe "Users", type: :request do
  before (:each) do
    @role = FactoryGirl.create(:admin)
    @designation = FactoryGirl.create(:designation , :designation_name => "Trainee")
    @user = FactoryGirl.create(:admin_user,:role => @role, :designation => @designation)
  end
  it "signs me in" do
    visit new_user_session_path
    within("#session") do
      fill_in 'Email', :with => 'mathewthomas@gmail.com'
      fill_in 'Password', :with => 'password'
    end
    click_button 'Log in'
    save_and_open_page
    expect(page).to have_content 'ADMIN PAGE'
  end
end