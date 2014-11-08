require 'spec_helper'

describe Grade, :type => :model do
  it "should create valid model" do
    expect(-> { FactoryGirl.create :grade }).not_to raise_error
  end
end
