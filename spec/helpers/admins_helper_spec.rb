require 'spec_helper'

describe AdminsHelper do 
  describe "methods" do
    
    it "Should return active if the boolean is false" do
      status(false).should == "Active"
    end
    
    it "Should return suspended if the boolean is true" do
      status(true).should == "Suspended"
    end
    
  end
end