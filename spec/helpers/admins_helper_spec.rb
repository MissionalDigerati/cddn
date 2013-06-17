require 'spec_helper'

describe AdminsHelper do 
  describe "methods" do
    
    it "Should return active if the boolean is false" do
      status(false).should == "Active"
    end
    
    it "Should return suspended if the boolean is true" do
      status(true).should == "Suspended"
    end

    it "should return the inputted argument, if it is blank then it will return a string saying nil" do
    	return_input_or_nil(nil).should == "nil"

    	return_input_or_nil("something").should == "something"
    end
    
  end
end