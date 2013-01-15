class Admin::EventsController < ApplicationController
  before_filter :authenticate_admin!, only: [:index, :destroy]
  def index
    @events = Event.all
  end
  
  def destroy
    @event = Event.find(params[:id])
    @attendees = Attendee.where("event_id = ?", params[:id])
    @event.delete
    @attendees.delete_all
    flash[:notice] = "Event has been deleted."
    redirect_to :back
  end
end