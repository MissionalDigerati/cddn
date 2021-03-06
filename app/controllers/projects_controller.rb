class ProjectsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :current_user_variable
  
  def new
    @project = Project.new
  end
  
  def create
    @project = Project.new(params[:project])
    @project.approved_project = @user.project_approved
    respond_to do |format|
      if @project.save
        Membership.membership_creation(@user.id, @project)
        if @project.approved_project == true  
          format.html {redirect_to project_path(@project)} 
          flash[:notice] = "Your project has been successfully created."
        else 
          format.html {redirect_to my_projects_user_path(current_user)}
          flash[:notice] = "Your Project has been submitted for approval, and will not be visible until approved."
        end
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
      @creator = @project.memberships.where(role: "creator").first.user
    else
      redirect_home
    end
  end
  
  def index
    @projects = Project.project_index_search(params[:language], params[:open_projects]).page(params[:page]).per(15)
    @project_rss = Project.approved_projects.include_creator.limit(10)
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
    @project.approved_project = @user.project_approved
    respond_to do |format|
      if @project.update_attributes(params[:project])
        if @project.approved_project == true  
          format.html {redirect_to project_path(@project)} 
          flash[:notice] = "Your project has been successfully updated."
        else 
          format.html {redirect_to my_projects_user_path(current_user)}
          flash[:notice] = "Your Project has been update, and is still pending approval, and will not be visible until approved."
        end
      else
        format.html { render action: "edit" }
        flash[:notice] = @project.errors.full_messages.to_sentence
      end
    end
  end
  
  def destroy
    @project = Project.find(params[:id])
    if current_admin || @project.memberships.where(role: "creator").first.user_id == current_user.id
      @project.destroy 
      respond_to do |format|
        format.html {redirect_to users_dashboard_path(current_user)}
        flash[:notice] = "Your Project has been deleted."
      end
    else
        redirect_home
    end
  end
  
  def join_project_request
    @project = Project.find(params[:id])
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
    if Membership.where("user_id = ? AND project_id = ?", @user.id, @project.id).present?
      Membership.leave_project(@project, @user)
      redirect_to :back
      flash[:notice] = "You have left the project."
    else
      redirect_home
    end
  end
  
end
