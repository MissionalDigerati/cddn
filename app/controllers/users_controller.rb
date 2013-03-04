class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:show]
  before_filter :user_suspended, except: [:show]
  
  def dashboard
    @user = User.include_networks.include_programmings.find(current_user)
    @projects = Project.joins(:memberships).where(memberships:{user_id: current_user.id, role:'creator'})
    @approvals = Membership.where(creator_id: current_user.id, status: "pending").page(params[:page]).per(10)
    @events = @user.events.upcoming_events.include_date.order_by_date
  end
  
  #this will be the brag page / the user show page.
  def show
    @user = User.include_networks.include_programmings.find(params[:id])
    @upcoming_events = Event.include_date.upcoming_events.joins_attendees.where(["attendees.user_id = ?", @user]).order_by_date.limit(5)
    @my_projects = Project.joins(:memberships).where(memberships:{user_id: @user}).limit(5)
  end
  
  def edit
    @user = current_user
  end
  
  def my_projects
    @my_projects = Project.joins(:memberships).where(memberships:{user_id: current_user.id, role:'creator'})
    @project_participation = Project.joins(:memberships).where(memberships:{user_id: current_user.id, role:'member', status: 'approved'})
  end
  
  def my_events
    @created_by_user = Event.joins_attendees.where(["attendees.user_id = ? AND attendee_type = ?", current_user.id, 'creator']).include_date.order_by_date
    @my_upcoming_events = Event.include_date.upcoming_events.joins_attendees.where(["attendees.user_id = ? AND attendee_type = ?", current_user.id, 'attendee']).order_by_date
    @my_past_events = Event.include_date.past_events.joins_attendees.where(["attendees.user_id = ? AND attendee_type = ?", current_user.id, 'attendee']).order_by_date
  end
  
  def update
    @user = current_user
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html {redirect_to users_dashboard_path(current_user), notice: "Your account information has been updated."}
      else
        format.html {render actionL "edit"}
        flash[:notice] = @user.errors if @user.errors.present?
      end
    end
  end
  
  def please_update
    @user = User.find(params[:id])
    User.update_notification(@user)
    redirect_to :back
  end
end