require 'spec_helper'
require 'rake'
load File.join(Rails.root, 'Rakefile')

describe EventDate do
  before(:each) do
    Gmaps4rails.stub!(:geocode).and_return([{:lat => 33, :lng => 33, :matched_address => ""}])
  end
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
  
  context "methods" do
    it "should create a valid event date, so long as they as a correct event is passsed to it" do
      FactoryGirl.create(:defaulted_state)
      FactoryGirl.create(:defaulted_country)
      event = FactoryGirl.create(:defaulted_event, event_date: Time.now.to_date.to_s, event_time: "7pm")
      EventDate.create_event_date(event)
      EventDate.first.date_of_event.should == Time.now.to_date
      EventDate.first.event_id.should == event.id
    end
    
    it "should update the last event date when the event is updated" do
      FactoryGirl.create(:defaulted_state)
      FactoryGirl.create(:defaulted_country)
      event = FactoryGirl.create(:defaulted_event, event_date: Time.now.to_date.to_s, event_time: "7pm")
      event_date = FactoryGirl.create(:defaulted_event_date, event_id: event.id, date_of_event: 1.week.ago.to_date.to_s)
      EventDate.update_event_date(event)
      EventDate.first.date_of_event.should == Time.now.to_date
      EventDate.first.event_id.should == event.id
      EventDate.first.id.should == event_date.id
    end
    
    it "should create a new date record for an event with recurring dates with the most current event having been passed" do
      FactoryGirl.create(:defaulted_state)
      FactoryGirl.create(:defaulted_country)
      weekly_event = FactoryGirl.create(:defaulted_event, recurring_date: true, recurring_schedule: "weekly", recurring_interval: 1)
      FactoryGirl.create(:defaulted_event_date, event_id: weekly_event.id, date_of_event: 3.days.ago.to_date.to_s)
      monthly_event = FactoryGirl.create(:defaulted_event, recurring_date: true, recurring_schedule: "monthly", recurring_interval: 1)
      FactoryGirl.create(:defaulted_event_date, event_id: monthly_event.id, date_of_event: 3.days.ago.to_date.to_s)
      EventDate.all.length.should == 2
      
      
      Rake::Task['db:date_update'].invoke
      EventDate.all.length.should == 4
      weekly_event.event_dates.last.date_of_event.should == 4.days.from_now.to_date
    end

    
    
  end
  
end
