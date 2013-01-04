class AdminsController < ApplicationController
  before_filter :authenticate_admin!, only: [:index]
  
  def index
    @users = User.all
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "User has been deleted."
    redirect_to :back
  end
end
