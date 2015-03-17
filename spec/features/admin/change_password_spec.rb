require 'spec_helper'

describe "admin change password", :type => :feature do
  it "allows an admin to change a user's password" do
    @user = FactoryGirl.create :user, first_name: 'Alice', last_name: 'User', email: 'alice@example.com'
    @admin = FactoryGirl.create :user, admin: true

    visit '/'
    click_link 'Login'

    fill_in 'Email', with: @admin.email
    fill_in 'Password', with: @admin.password
    click_button 'Sign in'

    visit '/admin/users'
    find(:xpath, "//tr[td[contains(.,'Alice')]]/td/a", :text => 'Edit').click
    fill_in 'Password', with: 'newpassword'
    fill_in 'Password confirmation', with: 'newpassword'
    click_button 'Update User'
    click_link 'Logout'
    click_link 'Login'

    fill_in 'Email', with: @user.email
    fill_in 'Password', with: 'newpassword'
    click_button 'Sign in'

    expect(page).to have_content 'Signed in successfully'
  end

  it "doesn't change a user's password when left blank" do
    @user = FactoryGirl.create :user, first_name: 'Alice', last_name: 'User', email: 'alice@example.com'
    @admin = FactoryGirl.create :user, admin: true

    visit '/'
    click_link 'Login'

    fill_in 'Email', with: @admin.email
    fill_in 'Password', with: @admin.password
    click_button 'Sign in'

    visit '/admin/users'
    find(:xpath, "//tr[td[contains(.,'Alice')]]/td/a", :text => 'Edit').click
    click_button 'Update User'
    click_link 'Logout'
    click_link 'Login'

    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Sign in'

    expect(page).to have_content 'Signed in successfully'
  end
end