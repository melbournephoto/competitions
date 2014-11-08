require 'spec_helper'

describe Section, :type => :model do
  it "should create valid model" do
    expect(-> { FactoryGirl.create :section }).not_to raise_error
  end
end