# Remove the current data
#
puts "removing all current data"
SocialMedia.destroy_all
State.destroy_all
Country.destroy_all
ProgrammingLanguage.destroy_all
License.destroy_all
Event.destroy_all
Project.destroy_all
User.destroy_all
Admin.destroy_all
# Grab the data files
#
social_media = YAML.load_file(File.join(Rails.root.to_s, "db", "seeds", "new_social_media.yml"))
countries = YAML.load_file(File.join(Rails.root.to_s, "db", "seeds", "Countries.yml"))
states = YAML.load_file(File.join(Rails.root.to_s, "db", "seeds", "States.yml"))
languages = YAML.load_file(File.join(Rails.root.to_s, "db", "seeds", "new_programming_language_list.yml"))
licenses = YAML.load_file(File.join(Rails.root.to_s, "db", "seeds", "new_programming_licenses.yml"))
# Seed the data
#
puts "Seeding Social Media Table"
#<SocialMedia id: nil, service: nil, created_at: nil, updated_at: nil> 
social_media["social_media"].each do |sm|
	puts sm
  SocialMedia.create({id: sm['id'], service: sm['service']})
end

puts "seeding countries"
countries['countries'].each do |c|
  puts c
  country = Country.new({iso: c['iso'], name: c['name'], printable_name: c['printable_name'], iso3: c['iso3'], numcode: c['numcode']})
  country.id = c['id']
  country.save
end

puts "seeding states"
states['states'].each do |s|
  puts s['state_long']
  state = State.new({state_long: s['state_long'], state_short: s['state_short']})
  state.id = s['id']
  state.save
end

puts "seeding programming_languages"
languages['programming_languages'].each do |l|
  puts l['language']
  language = ProgrammingLanguage.new({language: l['language']})
  language.id = l['id']
  language.save
end

puts "seeding programming licenses"
licenses['programming_licenses'].each do |pl|
  puts pl['id']
	license = License.new({license_title: pl['license_title']})
  license.id = pl['id']
  license.save
end

puts "Seeding complete."

