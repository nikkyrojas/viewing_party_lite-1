# frozen_string_literal: true

class MoviesController < ApplicationController
  before_action :require_user
  def index
    if params[:search].present?
      @movies = MovieFacade.movie_search(params[:search])
    elsif params[:search] == ''
      redirect_to user_discover_index_path(@current_user), notice: 'Error: Incorrect information entered'
    else
      @movies = MovieFacade.create_top_20_movies
    end
  end

  def show
    @movie = MovieFacade.create_individual_movie(params[:id])
    @cast = MovieFacade.create_cast(params[:id])
    @reviews = MovieFacade.create_reviews(params[:id])
  end
end
