class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:dashboard]
  
  def dashboard
  end
  
  #this will be the brag page / the user show page.
  def show
    @user = User.find(params[:id])
  end
  
  def please_update
    @user = User.find(params[:id])
    @user[:please_update] = true
    @user.save
    redirect_to :back
  end
end
