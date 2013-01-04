class AdminsController < ApplicationController
  before_filter :authenticate_admin!, only: [:users_index]
  
  def users_index
    @users = User.all
  end
end
