class Admin::UsersController < ApplicationController
  before_filter :authenticate_admin!, only: [:index, :destroy, :suspend]
  
  def index
    @users = User.all
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "User has been deleted."
    redirect_to :back
  end
  
  def suspend
    @user = User.find(params[:id])
    if @user.suspended == false
      @user[:suspended] = true
      @user.save
      flash[:notice] = "User has been suspended."
    else
      @user[:suspended] = false
      @user.save
      flash[:notice] = "User has been un-suspended."
    end
    redirect_to :back
  end
  
end
