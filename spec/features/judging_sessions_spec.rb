require 'spec_helper'

describe "login to judging" do
  before do
    @competition = Competition.create!(title: 'EDI', entries_open_at: 1.month.ago, entries_close_at: 1.month.from_now, results_published_at: 2.months.from_now)
  end

  it "valid judging key" do
    visit '/judging/sessions/' + @competition.judge_key

    expect(page).to have_content 'EDI'
  end

  it "doesn't allow login with invalid judging key" do
    visit '/judging/sessions/invalid'

    expect(page).to have_content 'Invalid judging link'
  end

  it "doesn't allow login with expired judging key" do
    competition = Competition.create!(title: 'EDI', entries_open_at: 1.month.ago, entries_close_at: 1.month.ago, results_published_at: 1.month.ago)
    visit '/judging/sessions/' + competition.judge_key
    expect(page).to have_content 'Invalid judging link'
  end

  it "doesn't allow access to authenticated url" do
    visit '/judging/entries'
    expect(page).to have_content 'You must use the judging link to sent to you to login'
  end
end