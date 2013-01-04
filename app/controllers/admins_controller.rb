class AdminsController < ApplicationController
  before_filter :authenticate_admin!, only: [:index]
  
  def index
    @users = User.all
  end
end
