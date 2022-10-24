# frozen_string_literal: true
before_action :require_user, only: [:index]
class DiscoverController < ApplicationController
  def index
    @user = User.find(params[:user_id])
  end
end
