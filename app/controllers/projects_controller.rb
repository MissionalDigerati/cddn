class ProjectsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  
  def new
    @project = Project.new
  end
  
  def create
    @user = current_user
    @project = Project.new(params[:project])
    @user.project_approved == true ? @project.approved_project = true : @project.approved_project = false
    respond_to do |format|
      if @project.save
        Membership.membership_creation(@user.id, @project, 'creator', 'active')
        format.html {redirect_to users_dashboard_path(current_user)}
        flash[:notice] = "Your project has been successfully created."
      else
        format.html {render action: "new"}
        flash[:notice] = @project.errors.full_messages.to_sentence
      end
    end
  end
  
  def show
    @project = Project.include_networks.include_memberships.include_programmings.find(params[:id])
    if @project.approved_project == true 
      @project
    else
      redirect_home
    end
  end
  
  def index
    @projects = Project.project_index_search(params[:language], params[:open_projects]).page(params[:page]).per(15)
  end
  
  def edit
    @membership = Membership.where("project_id = ? AND role = ?", params[:id], "creator").first
    if @membership.user_id == current_user.id
      @project = Project.find(params[:id])
    else
      redirect_home
    end
  end
  
  def update
    @project = Project.find(params[:id])
    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html {redirect_to users_dashboard_path(current_user)}
        flash[:notice] = "Your project has been successfully updated."
      else
        format.html { render action: "edit" }
        flash[:notice] = @project.errors.full_messages.to_sentence
      end
    end
  end
  
  def destroy
    @project = Project.find(params[:id])
    @project.destroy if @project.memberships.find_by_role("creator").user_id = current_user.id
    respond_to do |format|
      format.html {redirect_to users_dashboard_path(current_user)}
      flash[:notice] = "Your Project has been deleted."
    end
  end
  
  def join_project_request
    @project = Project.find(params[:id])
    @user = current_user
    if @project.accepts_requests == true && @project.approved_project == true
      Membership.join_project_request(@project, @user)
      redirect_to project_path(@project)
      flash[:notice] = "Request to join project has been sent."
    else
      redirect_home
    end
  end
  
  def leave_project
    @project = Project.find(params[:id])
    @user = current_user
    if Membership.where("user_id = ? AND project_id = ?", @user.id, @project.id).present?
      Membership.leave_project(@project, @user)
      redirect_to :back
      flash[:notice] = "You have left the project."
    else
      redirect_home
    end
  end
  
end
