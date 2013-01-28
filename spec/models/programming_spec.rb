require 'spec_helper'

describe Programming do
  
  describe "validations" do
    
    it "should not create a valid programming tag as no event, user or project is created it." do
      language = FactoryGirl.create(:defaulted_programming_language)
      FactoryGirl.build(:programming, programming_language_id: language.id).should_not be_valid
    end
    
    it "should create a valid programming languge tag for an event" do
      language = FactoryGirl.create(:defaulted_programming_language)
      user = FactoryGirl.create(:defaulted_user)
      event = FactoryGirl.create(:defaulted_event)
      FactoryGirl.create(:defaulted_attendee, user_id: user.id, event_id: event.id, attendee_type: "creator")
      tag = event.programmings.create({programming_language_id: language.id})
      tag.should be_valid
      tag.programmable_type.should == "Event"
      tag.programmable_id.should == event.id
      tag.programming_language_id.should == language.id
    end
    
    it "should create a valid programming language tag for a user" do
      user = FactoryGirl.create(:defaulted_user)
      language = FactoryGirl.create(:defaulted_programming_language)
      tag = user.programmings.create({programming_language_id: language.id})
      tag.should be_valid
      tag.programmable_type.should == "User"
      tag.programmable_id.should == user.id
      tag.programming_language_id.should == language.id
    end
    
  end
  
end
