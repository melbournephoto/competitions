require 'spec_helper'

describe User, :type => :model do
	it "should create valid model" do
		expect(-> {FactoryGirl.create :user}).not_to raise_error
	end
end