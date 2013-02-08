class MembershipsController < ApplicationController
  before_filter :authenticate_user!
  
  def project_update_memberships
    @membership = Membership.find(params[:id])
    if @membership.project.memberships.find_by_role('creator').user_id == current_user.id
      @membership.status = params[:mem_update]
      @membership.save
      redirect_to :back
      flash[:notice] = "User has been " + params[:mem_update]
    else
      redirect_to root_path
      flash[:notice] = "Unable to process your request."
    end
  end
  
end