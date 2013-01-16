class EventsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  
  def index
    @events = Event.events_by_approved_users(Event.all)
  end
  
  def new
    @event = Event.new
  end
  
  def show
    @event = Event.find(params[:id])
    if @event.attendees.find_by_attendee_type('creator').user.event_approved == true
      @event
    else
      redirect_to root_path
      flash[:notice] = "Unable to locate event."
    end
  end
  
  def create
    @user = current_user.id
    @event = Event.new(params[:event])
    respond_to do |format|
      if @event.save
        Attendee.creator(@user, @event)
        format.html {redirect_to users_dashboard_path(current_user)}
        flash[:notice] = "Your Event has been created!"
      else
        format.html {render action: "new"}
        flash[:notice] = @event.errors.full_messages.to_sentence
      end
    end
  end
  
  def edit
    @attendee = Attendee.where("event_id = ? AND attendee_type = ?", params[:id], "creator").first
    if @attendee.user_id == current_user.id
      @event = Event.find(params[:id])
    else
      redirect_to root_path
      flash[:notice] = "Unable to process your request."
    end
  end
  
  def update
    @event = Event.find(params[:id])
    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html {redirect_to my_events_event_path(current_user)} 
        flash[:notice] = "Your event was successfully updated."
      else
        format.html { render action: "edit" }
        flash[:notice] = @event.errors.full_messages.to_sentence
      end
    end
  end
  
  def destroy
    @event = Event.find(params[:id])
    @attendee = Attendee.where("user_id = #{current_user.id} AND event_id = #{@event.id}").first
    @event.delete
    @attendee.delete
    respond_to do |format|
      format.html {redirect_to my_events_event_path(current_user)}
      flash[:notice] = "Your event was successfully deleted."
    end
  end
  
  def my_events
    @current_user_attendee_creator = Attendee.where("user_id = #{current_user.id} AND attendee_type = 'creator'")
  end
  
end
