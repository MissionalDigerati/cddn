# Remove the current data
#
SocialMedia.destroy_all
# Grab the data files
#
social_media = YAML.load_file(File.join(Rails.root.to_s, "db", "seeds", "social_media_seed.yml"))
# Seed the data
#
puts "Seeding Social Media Table"
social_media["social_media"].each do |sm|
	puts sm
	new_sm = SocialMedia.new
	new_sm.service = sm
	new_sm.save!
end
puts "Seeding complete.  Have fun :)"