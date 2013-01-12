require 'spec_helper'

describe Event do
  describe "validations" do
    
    it "should create a valid record" do
      FactoryGirl.create(:defaulted_event).should be_valid
    end
    
    it "should not create a valid event without all of the require fields" do
      FactoryGirl.build(:defaulted_event, title: nil).should_not be_valid
    end
    
  end
end
