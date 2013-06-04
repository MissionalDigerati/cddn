class ApplicationController < ActionController::Base
  protect_from_forgery

  #this is an overwrite for devise, this redirects the user back to their dashboard after they login.
  #however if an admin is logging in then they are redirected to the home page instead.  
  def after_sign_in_path_for(resource)
    if resource == current_user
      users_dashboard_path(current_user)
    elsif resource == current_admin
      root_path
    end
  end
  
  def user_suspended
    if current_user.suspended == true
      sign_out :user
      flash[:notice] = "Your account has been suspended, you have been logged out. Please contact us for any additional information."
      redirect_to root_path
    end
  end
  
  def redirect_home
    redirect_to root_path
    flash[:notice] = "Unable to process your request."
  end
  
  def admin_auth
    unless current_admin
      redirect_home
    end
  end
  
  def current_user_variable
    @user = current_user if current_user.present?
  end

end
