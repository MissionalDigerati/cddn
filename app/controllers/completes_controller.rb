class CompletesController < ApplicationController

	def index(name)
		if params[:model] == "license"
			@licenses = License.order(:license_title).where("license_title like ?", "%#{params[:term]}%")
			render json: @licenses.map(&:license_title)
		end
	end

end
