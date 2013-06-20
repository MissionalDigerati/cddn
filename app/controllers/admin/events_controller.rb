class Admin::EventsController < ApplicationController
  before_filter :admin_auth
  before_filter :authenticate_admin!, only: [:index, :destroy, :event_to_approve, :allow_event_posting, :show]
  before_filter :set_event_var, only: [:show, :destroy]
  
  def index
    @events = Event.include_attendees_creator.includes_users
    @users = User.event_unapproved.attendee_event_creator.include_events.group("users.id")
  end
  
  def show
    @json = @event.to_gmaps4rails
  end
  
  def destroy
    @event.destroy
    flash[:notice] = "Event has been deleted."
    redirect_to :back
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

  private
    def set_event_var
      @event = Event.find(params[:id])
    end
  
end