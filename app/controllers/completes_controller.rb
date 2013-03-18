class CompletesController < ApplicationController

	def licenses
		@licenses = License.order(:license_title).where("license_title like ?", "%#{params[:term]}%")
		render json: @licenses.map(&:license_title)
	end

	def languages
		@languages = ProgrammingLanguage.order(:language).where("language like ?", "%#{params[:term]}%")
		render json: @languages.map(&:language)
	end

	def networks
		@networks = SocialMedia.order(:service).where("service like ?", "%#{params[:term]}%")
		render json: @networks.map(&:service)
	end

end
