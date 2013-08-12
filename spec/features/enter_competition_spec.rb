require 'spec_helper'

describe "enter a photo in a competition" do
  before do
    user = User.create!(email: 'ludivico@melbournephoto.org.au', password: 'password')
    competition = Competition.create!(title: 'EDI', entries_open_at: 1.month.ago, entries_close_at: 1.month.from_now)
    competition.sections.create!(title: 'Open', max_file_size: 1, max_width: 1200, max_height: 1200, entry_limit: 1)
    visit '/'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
  end

  it "uploads a valid file" do

    click_link 'Competitions'
    click_link 'EDI'
    click_link 'New Entry'

    select 'Open', from: 'Section'
    fill_in 'Title', with: 'Red Umbrella'
    attach_file('Photo', Rails.root.join('spec/fixtures/red_umbrella.jpg'))
    click_button 'Create Entry'

    expect(page).to have_content 'Your Entries'
    expect(page).to have_content 'Red Umbrella'
  end

  it "tries to upload a photo without a section" do
    click_link 'Competitions'
    click_link 'EDI'
    click_link 'New Entry'

    attach_file('Photo', Rails.root.join('spec/fixtures/red_umbrella.jpg'))
    click_button 'Create Entry'

    within ".entry_section_id" do
      expect(page).to have_content "can't be blank"
    end
  end

  it "tries to upload to a full section" do
    click_link 'Competitions'
    click_link 'EDI'
    click_link 'New Entry'

    select 'Open', from: 'Section'
    attach_file('Photo', Rails.root.join('spec/fixtures/red_umbrella.jpg'))
    click_button 'Create Entry'

    click_link 'New Entry'

    select 'Open', from: 'Section'
    attach_file('Photo', Rails.root.join('spec/fixtures/red_umbrella.jpg'))
    click_button 'Create Entry'

    within ".entry_section_id" do
      expect(page).to have_content "Maximum of 1 entry permitted in section 'Open'"
    end
  end

  it "edits an existing entry" do
    click_link 'Competitions'
    click_link 'EDI'
    click_link 'New Entry'

    select 'Open', from: 'Section'
    attach_file('Photo', Rails.root.join('spec/fixtures/red_umbrella.jpg'))
    click_button 'Create Entry'

    within ".your_entries" do
      click_link "Edit"
    end
    fill_in "Title", with: 'Red Umbrella'
    click_button 'Update Entry'

    within ".your_entries" do
      expect(page).to have_content 'Red Umbrella'
    end
  end
end