require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the Admin::UsersHelper. For example:
#
# describe Admin::UsersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe Admin::UsersHelper do
  context "methods" do
    
    it "should return the suspend user button if the user is active" do
      user = FactoryGirl.create(:defaulted_user)
      suspend_button(user).should == "<a href=\"/admin/users/1/suspend\" class=\"btn btn-mini btn-warning\" data-method=\"put\" rel=\"nofollow\">Suspend</a>"
    end
    
    it "should return the un suspend user button if the user is currently suspended" do
      user = FactoryGirl.create(:defaulted_user, suspended: true)
      suspend_button(user).should == "<a href=\"/admin/users/1/suspend\" class=\"btn btn-mini btn-info\" data-method=\"put\" rel=\"nofollow\">Un-suspend</a>"
    end
    
  end
end
