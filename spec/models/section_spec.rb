require 'spec_helper'

describe Section do
  it "should create valid model" do
    expect(-> { FactoryGirl.create :section }).not_to raise_error
  end
end