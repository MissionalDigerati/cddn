Feature: You should be able to add programming language tags for users, events, and projects
	As a user
	I want to bel able to manage my programming language tags on events projects and users
	
	# @javascript
	# 	Scenario: A user should be able to add language tags to their account
	# 		Given I am a user "Create_tags_user" and I am logged in
	# 		And I am on the home page
	# 		When I click the "Home | Dashboard" link
	# 		And I click the "edit_account_details" link
	# 		And I fill in "Nickname" with "Fred"
	# 		And I fill in tag label with "Ruby" and click enter
	# 		Then I should see "Your account information has been updated."
	# 		And I should be on the dashboard for "Create_tags_user"
	# 		And I should see "Fred"
	# 		And I should see "Ruby"
	# 
	# Scenario: A user should be able to retain their tags if they did not edit them through an update
	# 	Given I am a user "Create_tags_user_update" and I am logged in
	# 	And I am on the home page
	# 	When I click the "user_account_info_link" link
	# 	And I fill in "Nickname" with "Fred"
	# 	And I check the "Ruby" checkbox
	# 	And I click the "Update" button
	# 	Then I should see "Your account information has been updated."
	# 	And I should be on the dashboard for "Create_tags_user_update"
	# 	And I should see "Fred"
	# 	And I should see "Ruby"
	# 	When I click the "user_account_info_link" link
	# 	And I click the "Update" button
	# 	Then I should see "Your account information has been updated."
	# 	And I should be on the dashboard for "Create_tags_user_update"
	# 	And I should see "Ruby"
	# 
	# Scenario: A user should be able to remove language tags
	# 	Given I am a user "Create_tags_user_remove" and I am logged in
	# 	And I am on the home page
	# 	When I click the "user_account_info_link" link
	# 	And I fill in "Nickname" with "Fred"
	# 	And I check the "Ruby" checkbox
	# 	And I click the "Update" button
	# 	Then I should see "Your account information has been updated."
	# 	And I should be on the dashboard for "Create_tags_user_remove"
	# 	And I should see "Fred"
	# 	And I should see "Ruby"
	# 	When I click the "user_account_info_link" link
	# 	And I uncheck the "Ruby" checkbox
	# 	And I click the "Update" button
	# 	Then I should see "Your account information has been updated."
	# 	And I should be on the dashboard for "Create_tags_user_remove"
	# 	And I should not see "Ruby"
	
	
	# Scenario: A user should be able to create an event with language tags
	# 		Given I am a user "event_lang_tags_create" and I am logged in
	# 		And I am on the home page
	# 		When I click the "user_new_event" link
	# 		Then I should be on the new event page
	# 		And I fill in "Title" with "event"
	# 		And I fill in "Address 1" with "123 fake street"
	# 		And I fill in "event_city_province" with "San Jose"
	# 		And I fill in "Zip code" with "95123"
	# 		And I fill in "event_event_dates_attributes_0_date_of_event" with current time
	# 		And I fill in "event_event_dates_attributes_0_time_of_event" with current time
	# 		And I check the "Ruby" checkbox
	# 		And I click the "Submit" button
	# 		Then I should see "Your Event has been created!"
	# 		When I try to view the show page for the "event" event
	# 		Then I should see "Ruby"
	# 		
	# 	Scenario: A user that has language tags should be able to retain them through updating
	# 		Given I am a user "attend_event_test_1", and I have an event "event_tag_retention", and I have a ruby language tag, and I am logged in 
	# 		When I try to view the show page for the "event_tag_retention" event
	# 		Then I should see "Ruby"
	# 		And I should not see "SmallTalk"
	# 		When I click the "user_my_events" button
	# 		And I click the "Edit Event" button for "event_tag_retention"
	# 		And I click the "Submit" button
	# 		Then I should see "Your event was successfully updated."
	# 		And I click the "View Event" button for "event_tag_retention"
	# 		Then I should see "event_tag_retention"
	# 		And I should see "Ruby"
	# 		And I should not see "SmallTalk"
	# 		
	# 	Scenario:	A user should be able to edit an event and add programming language tags to it
	# 		Given I am a user "attend_event_test_1", and I have an event "event_tag_update", and I have a ruby language tag, and I am logged in 
	# 		When I try to view the show page for the "event_tag_update" event
	# 		Then I should see "Ruby"
	# 		And I should not see "SmallTalk"
	# 		When I click the "user_my_events" button
	# 		And I click the "Edit Event" button for "event_tag_update"
	# 		And I check the "SmallTalk" checkbox
	# 		And I click the "Submit" button
	# 		Then I should see "Your event was successfully updated."
	# 		And I click the "View Event" button for "event_tag_update"
	# 		Then I should see "event_tag_update"
	# 		And I should see "Ruby"
	# 		And I should see "SmallTalk"
	# 	
	# 	Scenario:	A user should be able to destroy language tags by unselecting them
	# 		Given I am a user "attend_event_test_1", and I have an event "event_tag_delete", and I have a ruby language tag, and I am logged in 
	# 		When I try to view the show page for the "event_tag_delete" event
	# 		Then I should see "Ruby"
	# 		When I click the "user_my_events" button
	# 		And I click the "Edit Event" button for "event_tag_delete"
	# 		And I uncheck the "Ruby" checkbox
	# 		And I click the "Submit" button
	# 		Then I should see "Your event was successfully updated."
	# 		And I click the "View Event" button for "event_tag_delete"
	# 		Then I should see "event_tag_delete"
	# 		And I should not see "Ruby"