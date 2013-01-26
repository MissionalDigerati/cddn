class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:dashboard, :edit]
  before_filter :user_suspended, except: [:show]
  
  def dashboard
    @user = User.include_networks.include_programmings.find(current_user)
  end
  
  #this will be the brag page / the user show page.
  def show
    # @user = User.find(params[:id])
    @user = User.include_networks.include_programmings.find(params[:id])
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html {redirect_to users_dashboard_path(current_user), notice: "Your account information has been updated."}
      else
        format.html {render actionL "edit"}
        flash[:notice] = @user.errors if @user.errors.present?
      end
    end
  end
  
  def please_update
    @user = User.find(params[:id])
    @user[:please_update] = true
    @user.save
    redirect_to :back
  end
end
