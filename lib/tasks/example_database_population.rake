
namespace :db do

  # ["schema_migrations", "users", "admins", "attendees", "networks", "social_media", "programming_languages", 
  #   "programmings", "memberships", "countries", "states", "event_dates", "events", "licenses", "projects"] 
  
  desc "Erase all data and fill database with example data"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
    puts "deleting data now"
    [User, Attendee, Programming, Membership, EventDate, Project, Event, Network].each(&:delete_all)

#     <User id: nil, email: "", encrypted_password: "", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, 
#     sign_in_count: 0, current_sign_in_at: nil, last_sign_in_at: nil, current_sign_in_ip: nil, last_sign_in_ip: nil, created_at: nil, 
#     updated_at: nil, first_name: nil, last_name: nil, nickname: nil, church: nil, bio: nil, city_province: nil, state_id: nil, 
#     country_id: nil, primary_role: nil, please_update: false, provider: nil, uid: nil, suspended: false, event_approved: false, 
#     project_approved: false> 
# 1.9.3p125 :002 >

    password = "password"
    puts "generating users now"


    User.populate 1 do |user| 
      user.email = "testuser@test.com"
      user.encrypted_password = User.new(:password => password).encrypted_password
      user.first_name = Faker::Name.first_name
      user.last_name = Faker::Name.last_name
      user.nickname = Faker::Name.first_name + "321"
      user.church = ['Vatican', 'SGCC', 'CJSC']
      user.bio = Faker::Lorem.sentences(sentence_count = 2)
      user.city_province = Faker::Address.city
      user.state_id = [*1..8]
      user.country_id = 226
      user.primary_role = ["Designer", "Artist", "Programmer", "Manager"]
      user.please_update = true
      user.suspended = false
      user.event_approved = true
      user.project_approved = true

      Programming.populate 5..10 do |programmings|
        #Programming(id: integer, programming_language_id: integer, 
        #programmable_id: integer, programmable_type: string, created_at: datetime, updated_at: datetime) 
        programmings.programming_language_id = [*1..50]
        programmings.programmable_id = user.id
        programmings.programmable_type = "User"
      end

      Network.populate 3 do |network|
        #Network(id: integer, social_media_id: integer, account_name: string, account_url: string, 
        #networkable_id: integer, networkable_type: string, created_at: datetime, updated_at: datetime) 
        network.social_media_id = 46
        network.account_name = "Facebook"
        network.account_url = "http://www.facebook.com"
        network.networkable_id = user.id
        network.networkable_type = "User"
      end

      Project.populate 5 do |project|
        # Project(id: integer, name: string, description: string, organization: string, accepts_requests: 
        # boolean, created_at: datetime, updated_at: datetime, approved_project: boolean, license_id: integer)
        project.name = "Project Name"
        project.description = Faker::Lorem.paragraph(sentence_count = 8)
        project.organization = Faker::Lorem.words(num = 1)
        project.accepts_requests = true
        project.approved_project = true
        project.license_id = 1

        Membership.populate 1 do |membership|
          #Membership(id: integer, user_id: integer, project_id: integer, status: string, role: string, 
          #created_at: datetime, updated_at: datetime, creator_id: integer)
          membership.user_id = user.id
          membership.project_id = project.id
          membership.status = "active"
          membership.role = "creator"
          membership.creator_id = user.id
        end

        Network.populate 3 do |network|
          #Network(id: integer, social_media_id: integer, account_name: string, account_url: string, 
          #networkable_id: integer, networkable_type: string, created_at: datetime, updated_at: datetime) 
          network.social_media_id = 46
          network.account_name = "Facebook"
          network.account_url = "http://www.facebook.com"
          network.networkable_id = project.id
          network.networkable_type = "Project"
        end

      end

      Event.populate 5 do |event|
        # <Event id: nil, title: nil, details: nil, address_1: nil, address_2: nil, city_province: nil, 
        # state_id: nil, country_id: nil, zip_code: nil, online_event: false, longitude: nil, latitude: nil, 
        # created_at: nil, updated_at: nil, approved_event: false, gmaps: false, recurring_date: false, recurring_schedule: nil, 
        # recurring_interval: nil> 
        event.title = "Event Title"
        event.details = Faker::Lorem.paragraph(sentence_count = 8)
        event.address_1 = "Golden Gate Bridge"
        event.city_province = "San Francisco"
        event.state_id = 5
        event.country_id = 226
        event.zip_code = "94129"
        event.online_event = false
        event.approved_event = true
        event.gmaps = false
        event.recurring_date = false
        event.longitude = -122.4769497
        event.latitude = 37.8086208

        Attendee.populate 1 do |a|
          #(id: integer, user_id: integer, event_id: integer, attendee_type: string, created_at: datetime, updated_at: datetime) 
          a.user_id = user.id
          a.event_id = event.id
          a.attendee_type = "creator"
        end

        EventDate.populate 1 do |event_date|
          #EventDate(id: integer, event_id: integer, date_of_event: date, time_of_event: time, created_at: datetime, updated_at: datetime) 
          event_date.event_id = event.id
          event_date.date_of_event = 2.days.from_now.to_date
          event_date.time_of_event = "6pm"
        end

        Network.populate 3 do |network|
          #Network(id: integer, social_media_id: integer, account_name: string, account_url: string, 
          #networkable_id: integer, networkable_type: string, created_at: datetime, updated_at: datetime) 
          network.social_media_id = 46
          network.account_name = "Facebook"
          network.account_url = "http://www.facebook.com"
          network.networkable_id = event.id
          network.networkable_type = "Event"
        end
      end
    end

    User.populate 40 do |user| 
      user.email = Faker::Internet.email
      user.encrypted_password = User.new(:password => password).encrypted_password
      user.first_name = Faker::Name.first_name
      user.last_name = Faker::Name.last_name
      user.nickname = Faker::Name.first_name + "321"
      user.church = ['Vatican', 'SGCC', 'CJSC']
      user.bio = Faker::Lorem.sentences(sentence_count = 2)
      user.city_province = Faker::Address.city
      user.state_id = [*1..8]
      user.country_id = 226
      user.primary_role = ["Designer", "Artist", "Programmer", "Manager"]
      user.please_update = true
      user.suspended = false
      user.event_approved = true
      user.project_approved = true

      Programming.populate 5..10 do |programmings|
        #Programming(id: integer, programming_language_id: integer, 
        #programmable_id: integer, programmable_type: string, created_at: datetime, updated_at: datetime) 
        programmings.programming_language_id = [*1..50]
        programmings.programmable_id = user.id
        programmings.programmable_type = "User"
      end

      Network.populate 3 do |network|
        #Network(id: integer, social_media_id: integer, account_name: string, account_url: string, 
        #networkable_id: integer, networkable_type: string, created_at: datetime, updated_at: datetime) 
        network.social_media_id = 46
        network.account_name = "Facebook"
        network.account_url = "http://www.facebook.com"
        network.networkable_id = user.id
        network.networkable_type = "User"
      end

      Project.populate 5 do |project|
        # Project(id: integer, name: string, description: string, organization: string, accepts_requests: 
        # boolean, created_at: datetime, updated_at: datetime, approved_project: boolean, license_id: integer)
        project.name = "Project Title"
        project.description = Faker::Lorem.sentences(sentence_count = 2)
        project.organization = Faker::Lorem.words(num = 1)
        project.accepts_requests = true
        project.approved_project = true
        project.license_id = 1

        Membership.populate 1 do |membership|
          #Membership(id: integer, user_id: integer, project_id: integer, status: string, role: string, 
          #created_at: datetime, updated_at: datetime, creator_id: integer)
          membership.user_id = user.id
          membership.project_id = project.id
          membership.status = "active"
          membership.role = "creator"
          membership.creator_id = user.id
        end

        Network.populate 3 do |network|
          #Network(id: integer, social_media_id: integer, account_name: string, account_url: string, 
          #networkable_id: integer, networkable_type: string, created_at: datetime, updated_at: datetime) 
          network.social_media_id = 46
          network.account_name = "Facebook"
          network.account_url = "http://www.facebook.com"
          network.networkable_id = project.id
          network.networkable_type = "Project"
        end
      end

      Event.populate 5 do |event|
        # <Event id: nil, title: nil, details: nil, address_1: nil, address_2: nil, city_province: nil, 
        # state_id: nil, country_id: nil, zip_code: nil, online_event: false, longitude: nil, latitude: nil, 
        # created_at: nil, updated_at: nil, approved_event: false, gmaps: false, recurring_date: false, recurring_schedule: nil, 
        # recurring_interval: nil> 
        event.title = "Event Title"
        event.details = Faker::Lorem.paragraph(sentence_count = 8)
        event.address_1 = "Golden Gate Bridge"
        event.city_province = "San Francisco"
        event.state_id = 5
        event.country_id = 226
        event.zip_code = "94129"
        event.online_event = false
        event.approved_event = true
        event.gmaps = false
        event.recurring_date = false
        event.longitude = -122.4769497
        event.latitude = 37.8086208

        Attendee.populate 1 do |a|
          #(id: integer, user_id: integer, event_id: integer, attendee_type: string, created_at: datetime, updated_at: datetime) 
          a.user_id = user.id
          a.event_id = event.id
          a.attendee_type = "creator"
        end

        EventDate.populate 1 do |event_date|
          #EventDate(id: integer, event_id: integer, date_of_event: date, time_of_event: time, created_at: datetime, updated_at: datetime) 
          event_date.event_id = event.id
          event_date.date_of_event = 2.days.from_now.to_date
          event_date.time_of_event = "6pm"
        end

        Network.populate 3 do |network|
          #Network(id: integer, social_media_id: integer, account_name: string, account_url: string, 
          #networkable_id: integer, networkable_type: string, created_at: datetime, updated_at: datetime) 
          network.social_media_id = 46
          network.account_name = "Facebook"
          network.account_url = "http://www.facebook.com"
          network.networkable_id = event.id
          network.networkable_type = "Event"
        end
      end
    end

    #creating records so the test user looks like he people to approve, as well as projects he contributres to. 
   
    user_1 = User.first

    events_user_is_attending = Event.last(5)

    events_user_is_attending.each do |event|
      event.attendees.create({user_id: user_1.id, event_id: event.id, attendee_type: "attendee"})
    end

    project_for_users_approval = Project.first

    users_for_stuff = User.last(5)

    users_for_stuff.each do |user|
      user.memberships.create({project_id: project_for_users_approval.id, status: "pending", role: "member", creator_id: project_for_users_approval.id})
    end

    projects_user_contributes_to = Project.last(5)

    projects_user_contributes_to.each do |project|
      project.memberships.create({user_id: user_1.id, status: "active", role: "member", creator_id: project.memberships.first.creator_id})
    end

    #creating programmings for the test user.
    ProgrammingLanguage.last(10).each do |language|
      user_1.programmings.create({programming_language_id: language.id})
    end

  end
end