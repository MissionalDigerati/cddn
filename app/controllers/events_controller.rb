class EventsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :current_user_variable
  
  #this will only display events that are created by authorized users
  def index
    @events = Event.upcoming_event_query(params[:language]).page(params[:page]).per(15)
  end
  
  def new
    @event = Event.new
    @event.event_dates.build
  end
  
  def show
    @event = Event.includes_users.include_networks.include_programmings.include_date.find(params[:id])
    if @event.approved_event == true 
      @event
    else
      redirect_home
    end
  end
  
  def create
    @event = Event.new(params[:event])
    @user.event_approved == true ? @event.approved_event = true : @event.approved_event = false
    respond_to do |format|
      if @event.save
        Attendee.attendee_creation(@user.id, @event, 'creator')
        format.html {redirect_to my_events_event_path(current_user)}
        @event.approved_event == true ? flash[:notice] = "Your Event has been created!" : flash[:notice] = "Your Event has been submitted for approval, and will not be visible until approved."
      else
        format.html {render action: "new"}
        flash[:notice] = @event.errors.full_messages.to_sentence
      end
    end
  end
  
  #I built in a safty measure to ensure that only the creator of an event is able to edit it. 
  # If someone else tries to access it, then they are redirected and told we are unable to process their request
  def edit
    @attendee = Attendee.where("event_id = ? AND attendee_type = ?", params[:id], "creator").first
    if @attendee.user_id == current_user.id
      @event = Event.find(params[:id])
    else
      redirect_home
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
    @event.destroy
    respond_to do |format|
      format.html {redirect_to my_events_event_path(current_user)}
      flash[:notice] = "Your event was successfully deleted."
    end
  end
  
  def my_events
    @current_user_attendee_creator = Attendee.where("user_id = #{current_user.id} AND attendee_type = 'creator'").include_event
    @current_user_event_attendee = Attendee.where("user_id = #{current_user.id} AND attendee_type = 'attendee'").include_event
  end
  
  def attend_event
    @event = Event.find(params[:id])
    @attendee = Attendee.where(user_id: @user.id, event_id: @event.id, attendee_type: 'attendee').first
    if @attendee.present?
      @attendee.destroy
      redirect_to event_path(@event)
      flash[:notice] = "You are no longer attending #{@event.title.capitalize}."
    else
      Attendee.attendee_creation(@user.id, @event, 'attendee')
      redirect_to event_path(@event)
      flash[:notice] = "You are now attending #{@event.title.capitalize}."
    end
  end
  
end
