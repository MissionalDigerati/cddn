# Remove the current data
#
SocialMedia.destroy_all
State.destroy_all
Country.destroy_all
# Grab the data files
#
social_media = YAML.load_file(File.join(Rails.root.to_s, "db", "seeds", "social_media_seed.yml"))
countries = YAML.load_file(File.join(Rails.root.to_s, "db", "seeds", "Countries.yml"))
states = YAML.load_file(File.join(Rails.root.to_s, "db", "seeds", "States.yml"))
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
  Country.create({iso: c['iso'], name: c['name'], printable_name: c['printable_name'], iso3: c['iso3'], numcode: c['numcode']})
end

states['states'].each do |s|
  State.create({state_long: s['state_long'], state_short: s['state_short']})
end
puts "Seeding complete.  Have fun :)"

