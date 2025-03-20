require 'rails_helper'

RSpec.feature "Home Page", type: :feature do
  include Devise::Test::IntegrationHelpers
  scenario "Visitor sees the welcome page" do
    visit root_path
    
    expect(page).to have_content("NRA Bullseye League")
    expect(page).to have_content("Welcome to the NRA Bullseye League Score Tracking Application")
    expect(page).to have_link("Sign Up", href: new_user_registration_path)
    expect(page).to have_link("Sign In", href: new_user_session_path)
  end
  
  scenario "Logged in user sees personalized welcome page" do
    user = create(:user)
    login_as(user, scope: :user)
    
    visit root_path
    
    expect(page).to have_content("NRA Bullseye League")
    expect(page).to have_content("Welcome to the NRA Bullseye League Score Tracking Application")
    expect(page).to have_link("View Profile", href: profile_path)
    expect(page).not_to have_link("Sign Up")
    expect(page).not_to have_link("Sign In")
  end
  
  scenario "User can navigate to sign in page" do
    visit root_path
    within(".navbar") do
      click_link "Sign In"
    end
    
    expect(current_path).to eq(new_user_session_path)
  end
  
  scenario "User can navigate to sign up page" do
    visit root_path
    within(".navbar") do
      click_link "Sign Up"
    end
    
    expect(current_path).to eq(new_user_registration_path)
  end
end
