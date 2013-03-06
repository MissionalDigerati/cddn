class EventsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show, :past_events]
  before_filter :current_user_variable
  
  #this will only display events that are created by authorized users
  def index
    @events = Event.upcoming_event_query(params[:language]).page(params[:page]).per(15)
    @event_rss = Event.approved_events.include_date.upcoming_events.include_programmings.limit(10)
  end
  
  def past_events
    @past_events = Event.past_event_query(params[:language]).page(params[:page]).per(15)
  end
  
  def new
    @event = Event.new(state_id: 5, country_id: 226)
    @event.event_dates.build
  end
  
  def show
    @event = Event.includes_users.include_networks.include_programmings.include_date.find(params[:id])
    if @event.approved_event == true 
      @event
      @json = @event.to_gmaps4rails
    else
      redirect_home
    end
  end
  
  def create
    @event = Event.new(params[:event])
    @event.approved_event = @user.event_approved
    respond_to do |format|
      if @event.save
        Attendee.attendee_creation(@user.id, @event, 'creator')
        EventDate.create_event_date(@event)
        if @event.approved_event == true
          format.html {redirect_to event_path(@event)}
          flash[:notice] = "Your Event has been created!"
        else
          format.html {redirect_to my_events_user_path(current_user)}
          flash[:notice] = "Your Event has been submitted for approval, and will not be visible until approved."
        end
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
    @event.approved_event = @user.event_approved
    respond_to do |format|
      if @event.update_attributes(params[:event])
        EventDate.update_event_date(@event)
        if @event.approved_event == true
          format.html {redirect_to event_path(@event)}
          flash[:notice] = "Your event was successfully updated."
        else
          format.html {redirect_to my_events_user_path(current_user)}
          flash[:notice] = "Your event has been update, and is still pending approval, and will not be visible until approved."
        end
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
      format.html {redirect_to my_events_user_path(current_user)}
      flash[:notice] = "Your event was successfully deleted."
    end
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
