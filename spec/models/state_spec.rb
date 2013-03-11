require 'spec_helper'

describe State do

	it "should return a select box containing all states" do
		FactoryGirl.create(:defaulted_state)
		State.state_drop_down.should == [["California", 5]]
	end


	it "should return the name of the state provided if available, else it will return a blank string" do
      state = FactoryGirl.create(:defaulted_state)
      State.display_state_name(state.id).should == "California"
      State.display_state_name(nil).should == ""
    end

end