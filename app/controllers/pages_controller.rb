class PagesController < ApplicationController
  # This is for the home page
  def home
    @projects = Project.approved_projects.limit(5).order("created_at DESC")
    @events = Event.approved_events.include_date.upcoming_events.limit(5).order_by_date
  end
end
