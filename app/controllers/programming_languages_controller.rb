class ProgrammingLanguagesController < ApplicationController
  
  def index
    @programming_languages = ProgrammingLanguage.order(:language)
    respond_to do |format|
      format.json { render json: @programming_languages.where("language like ?", "%#{params[:q]}%") }
    end
  end
  
end
