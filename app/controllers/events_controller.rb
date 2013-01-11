class EventsController < ApplicationController
  
  def new
    @event = Event.new
  end
  
  def create
    @user = current_user
    @event = Event.new(params[:event])
    respond_to do |format|
      if @event.save
        @attendee = @event.attendees.new
        @attendee.user_id = current_user.id 
        @attendee.attendee_type = "creator"
        @attendee.save
        format.html {redirect_to users_dashboard_path(current_user)}
        flash[:notice] = "Your Event has been created!"
      else
        format.html {render action: "new"}
        flash[:notice] = @event.errors.full_messages.to_sentence
      end
    end
  end
  

  #<Attendee id: nil, user_id: nil, event_id: nil, attendee_type: nil, created_at: nil, updated_at: nil> 
  
end
