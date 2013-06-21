class License < ActiveRecord::Base

	has_many :projects

	attr_accessible :id, :license_title
end
