class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings()

    @ratings_to_show =
    unless params[:ratings].nil?
      session[:ratings] = params[:ratings]
      params[:ratings].keys
    else
      unless session[:ratings].nil?
        session[:ratings].keys
      else
        @all_ratings
      end
    end

    @order_to_show = 
    unless params[:sorting].nil?
      session[:sorting] = params[:sorting]
      params[:sorting].keys
    else
      unless session[:sorting].nil?
        session[:sorting].keys
      else
        nil
      end
    end

    @movies = Movie.query(@ratings_to_show, @order_to_show)

    # @movies = Movie.with_ratings(@ratings_to_show).with_order(@order_to_show).movies
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
