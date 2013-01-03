class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  
  def twitter
    # raise request.env["omniauth.auth"].to_yaml
    user = User.from_twitter(request.env["omniauth.auth"])
    if user.persisted?
      flash.notice = "Signed in with Twitter!"
      sign_in user
      redirect_to users_dashboard_path(user)
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end
  end
  
  def github
    # raise request.env["omniauth.auth"].to_yaml
    user = User.from_github(request.env["omniauth.auth"])
    if user.persisted?
      flash.notice = "Signed in with Github!"
      sign_in user
      redirect_to users_dashboard_path(user)
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end
  end
  
  def facebook
    # raise request.env["omniauth.auth"].to_yaml
    user= User.from_facebook(request.env["omniauth.auth"])
    if user.persisted?
      flash.notice = "Signed in with Facebook!"
      sign_in user
      redirect_to users_dashboard_path(user)
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end
  end
  
  
end
