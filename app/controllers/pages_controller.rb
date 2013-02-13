class PagesController < ApplicationController
  # This is for the home page
  def home
    @projects = Project.approved_projects.limit(5).order("created_at DESC")
  end
end
