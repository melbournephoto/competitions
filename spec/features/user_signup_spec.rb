require 'spec_helper'

describe "user signup", :type => :feature do
  it "allows a successful signup" do
    visit '/'
    click_link 'Sign up'
    fill_in 'Email', with: 'ludovico@melbournephoto.org.au'
    fill_in 'user_password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    fill_in 'First name', with: 'Ludovico'
    fill_in 'Last name', with: 'Hart'
    click_button 'Sign up'
    expect(page).to have_content 'You have signed up successfully'
  end
end