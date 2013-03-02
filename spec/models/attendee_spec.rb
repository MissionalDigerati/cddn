require 'spec_helper'

describe Attendee do
  
  before(:each) do
    Gmaps4rails.stub!(:geocode).and_return([{:lat => 33, :lng => 33, :matched_address => ""}])
  end
  
  describe "validations" do  
    it "should create a successful attendee record" do
      FactoryGirl.create(:defaulted_state)
      FactoryGirl.create(:defaulted_country)
      fred = FactoryGirl.create(:defaulted_user, email: "fred@test.com")
      event = FactoryGirl.create(:defaulted_event)
      FactoryGirl.create(:defaulted_attendee, user_id: fred.id, event_id: event.id, attendee_type: "creator").should be_valid
      Attendee.first.user.email.should == "fred@test.com"
      Attendee.first.event.should == event
    end
    
    it "should not create a successful record without both a user and an event" do
      #note that there is no user
      FactoryGirl.create(:defaulted_state)
      FactoryGirl.create(:defaulted_country)
      event = FactoryGirl.create(:defaulted_event)
      FactoryGirl.build(:defaulted_attendee, event_id: event.id, attendee_type: "creator").should_not be_valid
    end
    
    it "should not create a successful record without all the necissary information" do
      FactoryGirl.build(:defaulted_attendee, user_id: nil, event_id: nil, attendee_type: nil).should_not be_valid
    end
    
  end
  
  describe "methods" do
    it "should create an attendee record so long the user and event are both provided" do
      FactoryGirl.create(:defaulted_state)
      FactoryGirl.create(:defaulted_country)
      user = FactoryGirl.create(:defaulted_user)
      user_id = user.id
      event = FactoryGirl.create(:defaulted_event)
      Attendee.attendee_creation(user_id, event, "creator")
      attendee = Attendee.first
      attendee.user_id.should == user.id
      attendee.event_id.should == event.id
      attendee.attendee_type.should == "creator"
    end
    
    it "should create an attendee record for an attendee type role so long as the credentials are correct" do
      FactoryGirl.create(:defaulted_state)
      FactoryGirl.create(:defaulted_country)
      user = FactoryGirl.create(:defaulted_user)
      user_id = user.id
      event = FactoryGirl.create(:defaulted_event)
      Attendee.attendee_creation(user_id, event, "attendee")
      attendee = Attendee.first
      attendee.user_id.should == user.id
      attendee.event_id.should == event.id
      attendee.attendee_type.should == "attendee"
    end
    
  end
  
end
