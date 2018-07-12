require 'spec_helper'

describe "entry", :type => :feature do
  describe "enter a photo in a regular competition" do
    before do
      @user = FactoryGirl.create :user, admin: true
      @alice = FactoryGirl.create :user, first_name: 'Alice', last_name: 'User', email: 'alice@example.com'
      @competition = FactoryGirl.create :competition, title: 'EDI'
      open_competition_series = FactoryGirl.create(:competition_series)
      set_subject_competition_series = FactoryGirl.create(:competition_series, title: 'Set Subject')
      @open_section = @competition.sections.create!(title: 'Open', max_file_size: 1, max_width: 1200, max_height: 1200, entry_limit: 1,
                                                    competition_series: open_competition_series)
      @people_section = @competition.sections.create!(title: 'Sunshine', max_file_size: 1, max_width: 1200, max_height: 1200, entry_limit: 1,
                                                      competition_series: set_subject_competition_series, order: 1)
      @a_grade = FactoryGirl.create :grade, title: 'A Grade', competition_series: open_competition_series
      @b_grade = FactoryGirl.create :grade, title: 'B Grade', competition_series: open_competition_series
      @set_subject_grade = FactoryGirl.create :grade, title: 'B Grade', competition_series: set_subject_competition_series
      CompetitionSeriesGrade.create!(competition_series: open_competition_series, user: @alice, grade: @b_grade)

      visit '/'
      click_link 'Login'

      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log in'
    end

    it 'uploads a file correctly' do
      visit '/admin/competitions'
      click_link 'EDI'
      click_link 'Add Entry'

      select 'Alice User', from: 'User'
      select 'Open', from: 'Section'
      fill_in 'Title', with: 'Red Umbrella'
      attach_file('Photo', Rails.root.join('spec/fixtures/red_umbrella.jpg'))
      click_button 'Create Entry'


      expect(page).to have_content('Alice User')
      expect(page).to have_content('EDI')
      expect(page).to have_content('Open')
    end


    it "tries to upload a photo without a section" do
      visit '/admin/competitions'

      click_link 'EDI'
      click_link 'Add Entry'

      attach_file('Photo', Rails.root.join('spec/fixtures/red_umbrella.jpg'))
      click_button 'Create Entry'

      within ".entry_section_id" do
        expect(page).to have_content "can't be blank"
      end
    end
  end
end
