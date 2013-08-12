require 'spec_helper'

describe Entry do
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
