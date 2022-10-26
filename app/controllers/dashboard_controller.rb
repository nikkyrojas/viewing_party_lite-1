class DashboardController < ApplicationController
  before_action :require_user
  def index
    @user = User.find(params[:id])
  end
end