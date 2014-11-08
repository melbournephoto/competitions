require 'spec_helper'

describe "entry", :type => :feature do
  describe "enter a photo in a regular competition" do
    before do
      @user = FactoryGirl.create :user
      @competition = FactoryGirl.create :competition, title: 'EDI'
      open_competition_series = FactoryGirl.create(:competition_series)
      set_subject_competition_series = FactoryGirl.create(:competition_series, title: 'Set Subject')
      @open_section = @competition.sections.create!(title: 'Open', max_file_size: 1, max_width: 1200, max_height: 1200, entry_limit: 1,
        competition_series: open_competition_series)
      @people_section = @competition.sections.create!(title: 'Sunshine', max_file_size: 1, max_width: 1200, max_height: 1200, entry_limit: 1,
        competition_series: set_subject_competition_series)
      @a_grade = FactoryGirl.create :grade, title: 'A Grade', competition_series: open_competition_series
      @b_grade = FactoryGirl.create :grade, title: 'B Grade', competition_series: open_competition_series
      @set_subject_grade = FactoryGirl.create :grade, title: 'B Grade', competition_series: set_subject_competition_series

      visit '/'
      click_link 'Login'

      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Sign in'
    end

    it "uploads a valid file with no grade set" do
      click_link 'Competitions'
      click_link 'EDI'
      click_link 'New Entry'

      expect(page).to have_content 'Select your grade'
      select 'B Grade', from: 'Grade'
      click_button 'Save'

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
      CompetitionSeriesGrade.create!(user: @user, competition_series: @open_section.competition_series, grade: @b_grade)

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
      CompetitionSeriesGrade.create!(user: @user, competition_series: @open_section.competition_series, grade: @b_grade)

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
      CompetitionSeriesGrade.create!(user: @user, competition_series: @open_section.competition_series, grade: @b_grade)

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

    it "tries to upload to a full competition" do
      CompetitionSeriesGrade.create!(user: @user, competition_series: @open_section.competition_series, grade: @b_grade)

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
  end
  it "enters end of year" do
    # end of year has one competition with more secitons
    @user = FactoryGirl.create :user, email: 'alan@alanharper.com.au'
    @competition = FactoryGirl.create :competition, title: 'End of Year 2014', entry_limit: 2
    competition_series = FactoryGirl.create(:competition_series)
    @open_section = @competition.sections.create!(title: 'Open', max_file_size: 2, max_width: 2000, max_height: 1200, entry_limit: 1,
      competition_series: competition_series)
    @people_section = @competition.sections.create!(title: 'People', max_file_size: 2, max_width: 2000, max_height: 1200, entry_limit: 1,
      competition_series: competition_series)
    @nature_section = @competition.sections.create!(title: 'Nature', max_file_size: 2, max_width: 2000, max_height: 1200, entry_limit: 1,
      competition_series: competition_series)
    @a_grade = FactoryGirl.create :grade, title: 'A Grade', competition_series: competition_series
    @b_grade = FactoryGirl.create :grade, title: 'B Grade', competition_series: competition_series
    @set_subject_grade = FactoryGirl.create :grade, title: 'B Grade', competition_series: competition_series

    CompetitionSeriesGrade.create!(user: @user, competition_series: @open_section.competition_series, grade: @b_grade)

    visit '/'
    click_link 'Login'

    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Sign in'

    click_link 'Competitions'
    click_link 'End of Year 2014'
    click_link 'New Entry'

    select 'Open', from: 'Section'
    attach_file('Photo', Rails.root.join('spec/fixtures/red_umbrella.jpg'))
    click_button 'Create Entry'
    click_link 'New Entry'

    select 'People', from: 'Section'
    attach_file('Photo', Rails.root.join('spec/fixtures/red_umbrella.jpg'))
    click_button 'Create Entry'
    click_link 'New Entry'

    select 'Nature', from: 'Section'
    attach_file('Photo', Rails.root.join('spec/fixtures/red_umbrella.jpg'))
    click_button 'Create Entry'

    expect(page).to have_content 'Competition entry limit reached'

  end
end