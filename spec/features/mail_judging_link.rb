require 'spec_helper'

describe "enter a photo in a competition", :type => :feature do
  it "sends a valid judging link" do
    user = FactoryGirl.create :user, :admin, email: 'admin@melbournephoto.org.au', password: 'password', password_confirmation: 'password'
    competition = FactoryGirl.create :competition, title: 'Febuary'

    visit '/'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'

    click_link 'Febuary'
    click_link 'E-Mail Judging Link'

    fill_in "Email", with: 'judge@melbournephoto.org.au'
    click_button 'Send'

    expect(page).to have_content 'Judging link sent to judge@melbournephoto.org.au'

    invite_email = ActionMailer::Base.deliveries.last.body

    url = invite_email.match(/(http:\/\/[a-z0-9.\/]+)/)[1]
    visit url
    expect(page).to have_content 'Entries for Febuary'
  end
end