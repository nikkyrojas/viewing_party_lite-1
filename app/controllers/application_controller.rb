# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :current_user

  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    return if @current_user

    flash[:error] = 'You must be a registered user to access this page'
    redirect_to root_path
  end
end
