class RegistrationsController < Devise::RegistrationsController
  
  # Please note that this inherits from devise. This sets the param please update to true when the user visits the page to update their contact information.
  def update  
    params[:please_update] = true
    super
  end
end