require 'spec_helper'

describe Network do
  describe "validations" do
    
    it "create a valid network record so long a social media id is provided" do
      social_media = FactoryGirl.create(:social_medium, service: "facebook")
      FactoryGirl.create(:defaulted_network, social_media_id: social_media.id).should be_valid
    end
    
    it "should require a social media id, as well as an account name and account url in order to be valid" do
      FactoryGirl.build(:defaulted_network, social_media_id: nil, account_name: nil, account_url: nil).should_not be_valid
    end
    
  end
end
