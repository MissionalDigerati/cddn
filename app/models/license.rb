class License < ActiveRecord::Base

	has_many :projects

	attr_accessible :license_title
end
