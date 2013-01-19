class Admin::EventsController < ApplicationController
  before_filter :authenticate_admin!, only: [:index, :destroy, :event_to_approve, :allow_event_posting]
  def index
    @events = Event.all
  end
  
  def show
    unless current_admin
      redirect_to root_path
      flash[:notice] = "Unable to process your request."
    else
      @event = Event.find(params[:id])
    end
  end
  
  def destroy
    @event = Event.find(params[:id])
    @attendees = Attendee.where("event_id = ?", params[:id])
    @event.delete
    @attendees.delete_all
    flash[:notice] = "Event has been deleted."
    redirect_to :back
  end
  
  def event_to_approve
    # queries all users that are not event approved that have created events a la attendee records.
    @users = User.event_unapproved.attendee_event_creator.include_events
  end
  
  def allow_event_posting
    @user = User.find(params[:id])
    @events = Event.joins(:attendees).where(attendees: {user_id: @user.id, attendee_type: 'creator'})
    if @user.event_approved == false
      @user[:event_approved] = true
      @user.save
      @events.update_all({approved_event: true})
      flash[:notice] = "User has been approved to post events."
    else
      @user[:event_approved] = false
      @user.save
      @events.update_all({approved_event: false})
      flash[:notice] = "User has been un-approed for returning events."
    end
    redirect_to :back
  end
  
end