class MembershipsController < ApplicationController
  before_filter :authenticate_user!
  
  def project_update_memberships
    @membership = Membership.find(params[:id])
    if @membership.project.memberships.find_by_role('creator').user_id == current_user.id
      Membership.membership_approve_deny(@membership, params[:mem_update])
      redirect_to :back
      flash[:notice] = "User has been " + params[:mem_update]
    else
      redirect_home
    end
  end
  
end