class Admin::ProjectsController < ApplicationController
  before_filter :admin_auth
  before_filter :authenticate_admin!, only: [:index, :show, :destroy, :allow_project_posting]
  before_filter :set_project_var, only: [:show, :destroy]
  
  def index
    @projects = Project.all
    @users = User.project_unapproved.memberships_project_creator.include_projects
  end
  
  def show
  end
  
  def destroy
    @project.destroy
    respond_to do |format|
      format.html {redirect_to admin_projects_path}
      flash[:notice] = "Project has been deleted."
    end
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

  private
    def set_project_var
      @project = Project.find(params[:id])
    end
  
end
