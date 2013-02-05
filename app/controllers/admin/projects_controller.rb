class Admin::ProjectsController < ApplicationController
  before_filter :authenticate_admin!, only: [:index, :destroy, :event_to_approve, :allow_event_posting]
  before_filter :admin_auth, only: [:show]
  
  def index
    @projects = Project.all
  end
  
  def show
    @project = Project.find(params[:id])
  end
  
  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    respond_to do |format|
      format.html {redirect_to admin_projects_path}
      flash[:notice] = "Project has been deleted."
    end
  end
  
  def project_to_approve
    @users = User.project_unapproved.memberships_project_creator.include_projects
  end
  
  def allow_project_posting
    @user = User.find(params[:id])
    @projects = Project.joins(:memberships).where(memberships:{user_id: @user.id, role:"creator"})
    if @user.project_approved == false
      @user[:project_approved] = true
      @user.save
      @projects.update_all({approved_project: true})
      flash[:notice] = "User has been approved to post projects."
    else
      @user[:project_approved] = false
      @user.save
      @events.update_all({approved_project: false})
      flash[:notice] = "User has been un-approed for returning projects."
    end
    redirect_to :back
  end
  
end
