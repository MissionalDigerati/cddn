require 'spec_helper'

describe EventDate do
  context "validations" do
    
    it "should create a valid event date." do |variable|
      FactoryGirl.create(:defaulted_state)
      FactoryGirl.create(:defaulted_country)
      event = FactoryGirl.create(:defaulted_event)
      FactoryGirl.create(:defaulted_event_date, event_id: event.id).should be_valid
    end
    
    it "should not create a valid event date record without all of the nesiccary information" do
      FactoryGirl.create(:defaulted_state)
      FactoryGirl.create(:defaulted_country)
      event = FactoryGirl.create(:defaulted_event)
      FactoryGirl.build(:defaulted_event_date, event_id: nil, date_of_event: nil, time_of_event: nil).should_not be_valid
    end
    
    it "should destroy the the corresponding event date if the event id destroyed" do
      FactoryGirl.create(:defaulted_state)
      FactoryGirl.create(:defaulted_country)
      event = FactoryGirl.create(:defaulted_event)
      FactoryGirl.create(:defaulted_event_date, event_id: event.id)
      event.destroy
      EventDate.all.length.should == 0
    end
    
  end
end
