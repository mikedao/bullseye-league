require 'rails_helper'

RSpec.feature "User Profiles", type: :feature do
  include Devise::Test::IntegrationHelpers
  let(:user) { create(:user, username: "testuser", email: "test@example.com") }
  

  scenario "User views their profile" do
    login_as(user, scope: :user)
    visit profile_path
    
    expect(page).to have_content("Profile")
    expect(page).to have_content(user.username)
    expect(page).to have_content(user.email)
    expect(page).to have_content(I18n.l(user.created_at.to_date, format: :long))
  end
  
  scenario "Unauthenticated user is redirected to login page" do
    visit profile_path
    
    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content("You need to sign in or sign up before continuing")
  end
  
  scenario "User navigates to profile via navbar" do
    login_as(user, scope: :user)
    visit root_path


    within(".navbar") do
      click_link user.username
      click_link "Profile"
    end
    
    expect(current_path).to eq(profile_path)
    expect(page).to have_content("Profile")
  end
end
