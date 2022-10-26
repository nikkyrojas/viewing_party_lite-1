# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user, :current_admin?
  
  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    if !current_user
      redirect_to root_path
      flash[:alert] = 'You must be logged in'
      
    end
  end

  def current_admin?
    user = User.find(session[:user_id]) if session[:user_id]
    user.role == "admin" if session[:user_id]
  end

  def require_admin
    !current_user&.admin?
    redirect_to root_path
    flash[:error] = "You don't have access"
  end
  
  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
