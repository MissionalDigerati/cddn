module Admin::UsersHelper
  
  def suspend_button(user)
    if user.suspended == false
      link_to "Suspend", suspend_admin_user_path(user), method: :put, class: "btn btn-mini btn-warning"
    else
      link_to "Un-suspend", suspend_admin_user_path(user), method: :put, class: "btn btn-mini btn-info"  
    end
  end
  
end