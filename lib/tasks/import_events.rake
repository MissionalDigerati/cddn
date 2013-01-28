
namespace :db do
  
  desc "fill database with example data"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
    User.populate 1 do |user|
      user.email = Faker::Name.first_name + "@exaxmplasdfasdfe.com"
      user.encrypted_password = "qdsasdfasdfammdmsdf"
      user.reset_password_token = "asdfasddf"
      user.remember_created_at = Time.now
      user.last_sign_in_at = Time.now
      user.current_sign_in_ip = "24.243.5323"
      user.created_at = Time.now
      user.updated_at = Time.now
      user.nickname = "asddnnnfnff"
      user.first_name = Faker::Name.first_name + "frdded"
      user.last_name = Faker::Name.last_name + "freddd"
      user.sign_in_count = 1
      user.state_id = 0
      user.country_id = 0
      user.suspended = false
      user.event_approved = true
      user.please_update = true
      user.church = "fake church"
      user.city_province = "fake city"
      user.primary_role = "salad maker"
      
      
      # contact.tags.name = "tags"
      #<User id: nil, email: "", encrypted_password: "", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 0, d: nil,
      # last_sign_in_at: nil, current_sign_in_ip: nil, last_sign_in_ip: nil, created_at: nil, updated_at: nil, first_name: nil, last_name: nil, nickname: nil, 
      # church: nil, bio: nil, city_province: nil, state_id: nil, country_id: nil, primary_role: nil, please_update: false, provider: nil, uid: nil, suspended: false, event_approved: false> 
      Event.populate 30 do |event|
        event.title = "asdf"
        event.details = "asdf"
        event.address_1 = "asdf"
        event.address_2 = "asdf"
        event.city_province = "asdf"
        event.state_id = 0
        event.country_id = 0
        event.zip_code = "12333"
        event.online_event = false
        event.created_at = Time.now
        event.approved_event = true 
        event.title = Time.now.to_date
        Attendee.populate 1 do |a|
          a.user_id = user.id
          a.event_id = event.id
          a.attendee_type = "creator"
        end
      end
      
      #<Event id: nil, title: nil, details: nil, address_1: nil, address_2: nil, city_province: nil, state_id: nil, 
      # country_id: nil, zip_code: nil, online_event: false, longitude: nil, latitude: nil, created_at: nil, updated_at: nil, approved_event: false, event_date: nil>
      
    end
  end
end