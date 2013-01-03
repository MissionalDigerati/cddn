class ApplicationController < ActionController::Base
  protect_from_forgery

  #this is an overwrite for devise, this redirects the user back to their dashboard after they login. 
  def after_sign_in_path_for(resource)
   users_dashboard_path(current_user)
  end
end
