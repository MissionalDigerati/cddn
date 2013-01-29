class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  
  def new
    @project = Project.new
  end
  
  def create
    @user_id = current_user.id
    @project = Project.new(params[:project])
    respond_to do |format|
      if @project.save
        Membership.membership_creation(@user_id, @project, 'creator', 'filler')
        format.html {render action: "show"}
        flash[:notice] = "Your project has been succesfully created."
      else
        format.html {render action: "new"}
        @project.errors.full_messages.to_sentence
      end
    end
  end
  
  def show
    @project = Project.find(params[:id])
  end
  
end
