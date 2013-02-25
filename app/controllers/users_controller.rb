class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:show]
  before_filter :user_suspended, except: [:show]
  
  def dashboard
    @user = User.include_networks.include_programmings.find(current_user)
    @projects = Project.joins(:memberships).where(memberships:{user_id: current_user.id, role:'creator'})
    @memberships_for_approval = @projects.includes(:memberships)
  end
  
  #this will be the brag page / the user show page.
  def show
    @user = User.include_networks.include_programmings.find(params[:id])
  end
  
  def edit
    @user = current_user
  end
  
  def my_projects
    @my_projects = Project.joins(:memberships).where(memberships:{user_id: current_user.id, role:'creator'})
    @project_participation = Project.joins(:memberships).where(memberships:{user_id: current_user.id, role:'member', status: 'approved'})
  end
  
  def my_events
    @current_user_attendee_creator = Attendee.where("user_id = #{current_user.id} AND attendee_type = 'creator'").include_event
    @current_user_event_attendee = Attendee.where("user_id = #{current_user.id} AND attendee_type = 'attendee'").include_event
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
