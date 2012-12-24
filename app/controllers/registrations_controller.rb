class RegistrationsController < Devise::RegistrationsController
  def update  
    params[:please_update] = true
    super
  end
end