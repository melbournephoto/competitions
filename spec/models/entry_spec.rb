require 'spec_helper'

describe Entry do
  it "creates valid model" do
    expect(-> { FactoryGirl.create :entry }).not_to raise_error
  end

  describe "title" do
    let(:title) { nil }
    let(:entry) { Entry.new(title: title) }
    subject { entry.title }

    describe "nil" do
      it { should == "Untitled" }
    end

    describe "blank" do
      let(:title) { "" }
      it { should == "Untitled" }
    end

    describe "title set" do
      let(:title) { "Sunrise" }
      it { should == "Sunrise" }
    end
  end
end
