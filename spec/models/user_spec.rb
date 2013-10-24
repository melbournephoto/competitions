require 'spec_helper'

describe User do
	it "should create valid model" do
		expect(-> {FactoryGirl.create :user}).not_to raise_error
	end
end