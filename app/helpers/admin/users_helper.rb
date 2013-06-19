module Admin::UsersHelper
  
  def suspend_button(user)
    if user.suspended == false
      link_to "Suspend", suspend_admin_user_path(user), method: :put
    else
      link_to "Un-suspend", suspend_admin_user_path(user), method: :put
    end
  end
  
end