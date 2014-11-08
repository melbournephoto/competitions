require 'spec_helper'

describe Entry, :type => :model do
  it "creates valid model" do
    expect(-> { FactoryGirl.create :entry }).not_to raise_error
  end

  describe "title" do
    let(:title) { nil }
    let(:entry) { Entry.new(title: title) }
    subject { entry.title }

    describe "nil" do
      it { is_expected.to eq("Untitled") }
    end

    describe "blank" do
      let(:title) { "" }
      it { is_expected.to eq("Untitled") }
    end

    describe "title set" do
      let(:title) { "Sunrise" }
      it { is_expected.to eq("Sunrise") }
    end
  end
end
