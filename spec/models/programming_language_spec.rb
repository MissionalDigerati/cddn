require 'spec_helper'

describe ProgrammingLanguage do
  describe "validations" do
    
    it "should not create a valid programming language as no language is provided" do
      FactoryGirl.build(:defaulted_programming_language, language: nil).should_not be_valid
    end
    
    it "should create a valid programming language if all the correct information is provided" do
      FactoryGirl.create(:defaulted_programming_language, language: "SmallTalk").should be_valid
    end
    
  end
end
