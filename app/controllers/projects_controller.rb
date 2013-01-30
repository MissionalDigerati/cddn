class ProjectsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  
  def new
    @project = Project.new
  end
  
  def create
    @user_id = current_user.id
    @project = Project.new(params[:project])
    respond_to do |format|
      if @project.save
        Membership.membership_creation(@user_id, @project, 'creator', 'filler')
        format.html {redirect_to project_path(@project)}
        flash[:notice] = "Your project has been successfully created."
      else
        format.html {render action: "new"}
        @project.errors.full_messages.to_sentence
      end
    end
  end
  
  def show
    @project = Project.find(params[:id])
  end
  
  def index
    @projects = Project.include_creator
  end
  
  def edit
    @membership = Membership.where("project_id = ? AND role = ?", params[:id], "creator").first
    if @membership.user_id == current_user.id
      @project = Project.find(params[:id])
    else
      redirect_to root_path
      flash[:notice] = "Unable to process your request."
    end
  end
  
  def update
    @project = Project.find(params[:id])
    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html {redirect_to project_path(@project)}
        flash[:notice] = "Your project has been successfully updated."
      else
        format.html { render action: "edit" }
        flash[:notice] = @project.errors.full_messages.to_sentence
      end
    end
  end
  
  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    respond_to do |format|
      format.html {redirect_to users_dashboard_path(current_user)}
      flash[:notice] = "Your Project has been deleted."
    end
  end
  
end
