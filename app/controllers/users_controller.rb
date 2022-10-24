# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @viewing_parties = @user.viewing_parties
    movies_ids = @viewing_parties.map(&:movie_id)
    @movies = MovieFacade.create_movies(movies_ids)
  end

  def create
    # binding.pry
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome, #{@user.name}!"
      redirect_to "/users/#{@user.id}"
    else
      redirect_to '/register'
      flash[:alert] = "Error: #{error_message(@user.errors)}"
      #flash[:error] = user.errors.full_messages

    end
  end

  private

  # def user_params
  #   params.require(:user).permit(:name, :email)
  # end
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
