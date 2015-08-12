require 'rails_helper'
RSpec.describe "Users", type: :request do
  before (:each) do
    @role = FactoryGirl.create(:admin)
    @designation = FactoryGirl.create(:designation)
    @user = FactoryGirl.create(:admin_user, role: @role, designation: @designation)
    visit new_user_session_path
    within("#session") do
      fill_in 'Email', :with => 'mathewthomas@gmail.com'
      fill_in 'Password', :with => 'password'
    end
    click_button 'Log in'
  end
  it "signs me in" do
    save_and_open_page
    expect(page).to have_content 'ADMIN PAGE'
  end
  it "creates a user" do
    click_link 'New User'
    save_and_open_page
    expect(page).to have_content 'NEW USER'
  end
end
