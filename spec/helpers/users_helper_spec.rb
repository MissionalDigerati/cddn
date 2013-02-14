require 'spec_helper'

describe ApplicationHelper do
  context "methods" do
    
    it "should retrun the user's nickname and provider rather than the email" do
      user = FactoryGirl.build(:defaulted_user, email: nil, encrypted_password: nil,  provider: "twitter", nickname: "Nickname123")
      logged_in_as(user).should == "Nickname123 from twitter"
    end
    
    it "should return the user's email becuase the nickname and provider are not present" do
      user = FactoryGirl.build(:defaulted_user, email: "123fake@emailtest.com", provider: nil, nickname: nil)
      logged_in_as(user).should == "123fake@emailtest.com"
    end
    
    
    it "should return the event creator nickname if available" do
      user = FactoryGirl.create(:defaulted_user, nickname: "fred")
      event = FactoryGirl.create(:defaulted_event)
      attendee = FactoryGirl.create(:defaulted_attendee, user_id: user.id, event_id: event.id, attendee_type: "creator")
      attendee_creator_name(event).should == "fred"
    end
    
    it "should return the events creator's first name if it is available and nickname is not available" do
      user = FactoryGirl.create(:defaulted_user, first_name: "rory")
      event = FactoryGirl.create(:defaulted_event)
      attendee = FactoryGirl.create(:defaulted_attendee, user_id: user.id, event_id: event.id, attendee_type: "creator")
      attendee_creator_name(event).should == "rory"
    end 
    
    it "should return the user's email if both the nickname and the first name are unavailable" do
      user = FactoryGirl.create(:defaulted_user, email: "fake@fake.com")
      event = FactoryGirl.create(:defaulted_event)
      attendee = FactoryGirl.create(:defaulted_attendee, user_id: user.id, event_id: event.id, attendee_type: "creator")
      attendee_creator_name(event).should == "fake@fake.com"
    end
    
    it "Should return yes or no depending on if the provided information is true or false" do
      yes_or_no(true).should == "Yes"
      yes_or_no(false).should == "No"
    end
    
    it "should return true if the id for a language id passed in, is contained with the array of languages" do
      check_lang([1, 2, 4], 3).should == false
      check_lang([1, 2, 4], 1).should == true
    end
    
    it "should return a link the the users profile when the user instance is provided. It will return nickname if available or email if not" do
      user_with_nickname = FactoryGirl.create(:defaulted_user, nickname: "The Master")
      link_to_users_profile(user_with_nickname).should == "<a href=\"/users/1\">The master</a>"
      user_with_nickname = FactoryGirl.create(:defaulted_user, nickname: nil, email: "123@fakeemail.com")
      link_to_users_profile(user_with_nickname).should == "<a href=\"/users/2\">123@fakeemail.com</a>"
    end
    
    
    it "should return a link the the network" do
      social_media = FactoryGirl.create(:social_medium, service: "facebook")
      network = FactoryGirl.create(:defaulted_network, social_media_id: social_media.id)
      networking_link(network).should == "<a href=\"http://www.facebook.com/\">Sammy Simmons</a>"
    end
    
    
    it "should return the name of the social network such as FaceBook: " do
      social_media = FactoryGirl.create(:social_medium, service: "facebook")
      network = FactoryGirl.create(:defaulted_network, social_media_id: social_media.id)
      network_service(network).should == "facebook: "
    end
    
    it "should return a select box containing all states" do
      FactoryGirl.create(:defaulted_state)
      state_drop_down.should == [["California", 1]]
    end
    
    it "should return a select box containing all countries" do
      FactoryGirl.create(:defaulted_country)
      country_drop_down.should == [["United States", 1]]
    end
    
    it "should return the name of the state provided if available, else it will return a blank string" do
      state = FactoryGirl.create(:defaulted_state)
      display_state_name(state.id).should == "California"
      display_state_name(nil).should == ""
    end
    
    
    it "should return the name of the country that is associated with the id, if one is not provided it should return a blank string" do
      country = FactoryGirl.create(:defaulted_country)
      display_country_name(country.id).should == "United States"
      display_country_name(nil).should == ""
    end
    
  end
  
end