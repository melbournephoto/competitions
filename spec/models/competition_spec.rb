require 'spec_helper'

describe Competition do
  it "creates a valid model" do
    expect(-> { FactoryGirl.create(:competition) }).not_to raise_error
  end
  let(:entries_open_at) { 1.month.from_now }
  let(:entries_close_at) { 2.months.from_now }
  let(:results_published_at) { 3.months.from_now }
  let(:competition) { FactoryGirl.create(:competition, title: 'EDI', entries_open_at: entries_open_at, entries_close_at: entries_close_at, results_published_at: results_published_at) }

  describe "open for entry" do
    subject { competition }

    describe "isn't open for entry before entries_open_at" do
      let(:entries_open_at) { 1.month.from_now }
      it { should_not be_open_for_entry }
    end

    describe "is open between entries openning and closing" do
      let(:entries_open_at) { 1.month.ago }
      let(:entires_close_at) { 1.month.from_now }
      it { should be_open_for_entry }
    end

    describe "is closed once entries have closed" do
      let(:entires_open_at) { 2.months.ago }
      let(:entries_close_at) { 1.month.ago }
      it { should_not be_open_for_entry }
    end
  end

  it "sets a judges key" do
    expect(competition.judge_key).to_not be_blank
  end
end
