# Remove the current data
#
SocialMedia.destroy_all
State.destroy_all
Country.destroy_all
ProgrammingLanguage.destroy_all
License.destroy_all
# Grab the data files
#
social_media = YAML.load_file(File.join(Rails.root.to_s, "db", "seeds", "social_media_seed.yml"))
countries = YAML.load_file(File.join(Rails.root.to_s, "db", "seeds", "Countries.yml"))
states = YAML.load_file(File.join(Rails.root.to_s, "db", "seeds", "States.yml"))
languages = YAML.load_file(File.join(Rails.root.to_s, "db", "seeds", "programming_languages.yml"))
licenses = YAML.load_file(File.join(Rails.root.to_s, "db", "seeds", "programming_licenses.yml"))
# Seed the data
#
puts "Seeding Social Media Table"
social_media["social_media"].each do |sm|
	puts sm
	new_sm = SocialMedia.new
	new_sm.service = sm
	new_sm.save!
end
countries['countries'].each do |c|
  puts c
  country = Country.new({iso: c['iso'], name: c['name'], printable_name: c['printable_name'], iso3: c['iso3'], numcode: c['numcode']})
  country.id = c['id']
  country.save
end

states['states'].each do |s|
  puts s['state_long']
  state = State.new({state_long: s['state_long'], state_short: s['state_short']})
  state.id = s['id']
  state.save
end

languages['programming_languages'].each do |l|
	puts l
  ProgrammingLanguage.create({language: l})
end

licenses['programming_licenses'].each do |license|
	puts license
	License.create({license_title: license})
end

puts "Seeding complete.  Have fun :)"

