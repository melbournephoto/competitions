require 'spec_helper'

describe "judge entries" do
  before do
    @competition = Competition.create!(title: 'EDI', entries_open_at: 1.month.ago, entries_close_at: 1.month.from_now, results_published_at: 2.months.from_now)
    @user = User.create!(email: 'ludvico@melbournephoto.org.au', password: 'photography')
    @section = Section.create!(title: 'Open', max_file_size: 1, entry_limit: 10, max_height: 1200, max_width: 1200)
    Rating.create!(title: 'Commended')
    @photo = ActionDispatch::Http::UploadedFile.new(
        tempfile: File.new(Rails.root.join('spec/fixtures/red_umbrella.jpg')),
        filename: File.basename(File.new(Rails.root.join('spec/fixtures/red_umbrella.jpg')))
    )
  end

  it "allows a judge to enter a rating and notes" do
    @entry = Entry.create!(competition: @competition, user: @user, section: @section, photo: @photo)

    visit '/judging/sessions/' + @competition.judge_key
    click_link 'Rate'
    fill_in 'Notes', with: 'A generic comment'
    select 'Commended', from: 'Rating'
    click_button 'Save and back to Entries'

    expect(page).to have_content 'A generic comment'
    expect(page).to have_content 'Commended'
  end

  it "allows a judge to save and go to the next unrated entry" do
    @first_entry = Entry.create!(competition: @competition, user: @user, section: @section, photo: @photo)
    @second_entry = Entry.create!(competition: @competition, user: @user, section: @section, photo: @photo)

    visit '/judging/sessions/' + @competition.judge_key
    click_link('Rate', match: :first)
    fill_in 'Notes', with: 'A generic comment'
    select 'Commended', from: 'Rating'
    click_button 'Save and next unrated'

    fill_in 'Notes', with: 'Second entry'
    select 'Commended', from: 'Rating'
    click_button 'Save and next unrated'

    expect(page).to have_content 'A generic comment'
    expect(page).to have_content 'Second entry'
  end

  it "returns to entry list if next unrated is chosen and all entries are rated" do
    @first_entry = Entry.create!(competition: @competition, user: @user, section: @section, photo: @photo)

    visit '/judging/sessions/' + @competition.judge_key
    click_link('Rate', match: :first)
    fill_in 'Notes', with: 'A generic comment'
    select 'Commended', from: 'Rating'
    click_button 'Save and next unrated'
    expect(page).to have_content 'Entries for'
  end
end