class Admin::EventsController < ApplicationController
  before_filter :authenticate_admin!, only: [:index, :destroy, :event_to_approve, :allow_event_posting]
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
  
  def event_to_approve
    @users = User.users_event_approval(User.where(event_approved: false))
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