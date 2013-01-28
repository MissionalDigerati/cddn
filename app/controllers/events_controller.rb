class EventsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  
  #this will only display events that are created by authorized users
  def index
    if params[:language].present?
      @events = Event.approved_events.joins(:programmings).where(programmings: {programming_language_id: params[:language]}).page(params[:page]).per(10)
    else
      @events = Event.approved_events.include_programmings.page(params[:page]).per(10)
    end
  end
  
  def new
    @event = Event.new
    @event.programmings.build
  end
  
  def show
    @event = Event.include_networks.include_programmings.find(params[:id])
    if @event.approved_event == true 
      @event
    else
      redirect_to root_path
      flash[:notice] = "Unable to process your request."
    end
  end
  
  def create
    @user = current_user
    @event = Event.new(params[:event])
    @user.event_approved == true ? @event.approved_event = true : @event.approved_event = false
    respond_to do |format|
      if @event.save
        Attendee.attendee_creation(@user.id, @event, 'creator')
        format.html {redirect_to my_events_event_path(current_user)}
        flash[:notice] = "Your Event has been created!"
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
    @event.destroy
    respond_to do |format|
      format.html {redirect_to my_events_event_path(current_user)}
      flash[:notice] = "Your event was successfully deleted."
    end
  end
  
  def my_events
    @current_user_attendee_creator = Attendee.where("user_id = #{current_user.id} AND attendee_type = 'creator'")
    @current_user_event_attendee = Attendee.where("user_id = #{current_user.id} AND attendee_type = 'attendee'")
  end
  
  def attend_event
    @user = current_user.id
    @event = Event.find(params[:id])
    @attendee = Attendee.where(user_id: @user, event_id: @event.id, attendee_type: 'attendee').first
    if @attendee.present?
      @attendee.delete
      redirect_to event_path(@event)
      flash[:notice] = "You are no longer attending #{@event.title.capitalize}."
    else
      Attendee.attendee_creation(@user, @event, 'attendee')
      redirect_to event_path(@event)
      flash[:notice] = "You are now attending #{@event.title.capitalize}."
    end
  end
  
end
