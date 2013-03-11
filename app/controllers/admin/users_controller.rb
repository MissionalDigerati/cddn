class Admin::UsersController < ApplicationController
  before_filter :authenticate_admin!, only: [:index, :destroy, :suspend]
  before_filter :set_user_var, only: [:destroy, :suspend]
  
  def index
    @users = User.all
  end
  
  def destroy
    @user.destroy
    flash[:notice] = "User has been deleted."
    redirect_to :back
  end
  
  def suspend
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

  private
    def set_user_var
      @user = User.find(params[:id])
    end
end
