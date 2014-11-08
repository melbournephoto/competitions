require 'spec_helper'

describe "judge entries", :type => :feature do
  before do
    @competition = FactoryGirl.create :competition
    @competition_series = FactoryGirl.create :competition_series
    @user = FactoryGirl.create :user
    @section = Section.create!(title: 'Open', max_file_size: 1, entry_limit: 10, max_height: 1200, max_width: 1200, competition: @competition, competition_series: @competition_series)
    Rating.create!(title: 'Commended')
    @photo = ActionDispatch::Http::UploadedFile.new(
        tempfile: File.new(Rails.root.join('spec/fixtures/red_umbrella.jpg')),
        filename: File.basename(File.new(Rails.root.join('spec/fixtures/red_umbrella.jpg')))
    )
    @grade = Grade.create!(title: 'A Grade', competition_series: @competition_series)
  end

  it "allows a judge to enter a rating and notes" do
    @entry = FactoryGirl.create(:entry, competition: @competition, user: @user, section: @section, photo: @photo)

    visit '/judging/sessions/' + @competition.judge_key
    click_link 'Rate'
    fill_in 'Notes', with: 'A generic comment'
    choose 'Commended'
    click_button 'Save and back to Entries'

    expect(page).to have_content 'A generic comment'
    expect(page).to have_content 'Commended'
  end

  it "allows a judge to save and go to the next unrated entry" do
    @first_entry = FactoryGirl.create(:entry, competition: @competition, user: @user, section: @section, photo: @photo, grade: @grade)
    @second_entry = FactoryGirl.create(:entry, competition: @competition, user: @user, section: @section, photo: @photo, grade: @grade)

    visit '/judging/sessions/' + @competition.judge_key
    click_link('Rate', match: :first)
    fill_in 'Notes', with: 'A generic comment'
    choose 'Commended'
    click_button 'Save and next unrated'

    fill_in 'Notes', with: 'Second entry'
    choose 'Commended'
    click_button 'Save and next unrated'

    expect(page).to have_content 'A generic comment'
    expect(page).to have_content 'Second entry'
  end

  it "returns to entry list if next unrated is chosen and all entries are rated" do
    @first_entry = FactoryGirl.create(:entry, competition: @competition, user: @user, section: @section, photo: @photo)

    visit '/judging/sessions/' + @competition.judge_key
    click_link('Rate', match: :first)
    fill_in 'Notes', with: 'A generic comment'
    choose 'Commended'
    click_button 'Save and next unrated'
    expect(page).to have_content 'Entries for'
  end
end