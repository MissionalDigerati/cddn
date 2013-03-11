require 'spec_helper'

describe Attendee do

	it "should return a select box containing all countries" do
	  FactoryGirl.create(:defaulted_country)
	  Country.country_drop_down.should == [["United States", 226]]
	end

end