class Admin::ProjectsController < ApplicationController
  before_filter :authenticate_admin!, only: [:index, :destroy, :event_to_approve, :allow_event_posting]
  before_filter :admin_auth, only: [:show]
  
  def index
    
  end
end
