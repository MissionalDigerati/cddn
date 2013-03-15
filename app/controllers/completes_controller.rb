class CompletesController < ApplicationController

	def index
		@licenses = License.order(:license_title).where("license_title like ?", "%#{params[:term]}%")
		render json: @licenses.map(&:license_title)
	end

end
