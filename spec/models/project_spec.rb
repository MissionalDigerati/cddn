require 'spec_helper'

describe Project do
  describe "validations" do
    
      it "should create a valid project" do
        FactoryGirl.create(:defaulted_project).should be_valid
      end
    
      it "shold not create a valid project if all the approprate information is not provided" do
        FactoryGirl.build(:defaulted_project, name: nil).should_not be_valid
      end
      
  end
end
