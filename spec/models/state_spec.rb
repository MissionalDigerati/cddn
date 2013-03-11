require 'spec_helper'

describe Attendee do

	it "should return a select box containing all states" do
		FactoryGirl.create(:defaulted_state)
		State.state_drop_down.should == [["California", 5]]
	end

end