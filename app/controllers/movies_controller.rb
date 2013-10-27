class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find params[:id]
  end

  def new
    @movie = Movie.new
    @categories = Category.all.map(&:title)
  end

  def create
    Movie.create movie_params
    redirect_to :root
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    movie = Movie.find params[:id]
    movie.update movie_params
    redirect_to movie_path movie
  end

  def filter
    @movies = Movie.by_category(filter_category_params).by_rating(filter_rating_params)
    render :template => 'movies/index'
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :description, :rating, :category_id)
  end

  def filter_category_params
    params.require(:category)
  end

  def filter_rating_params
    params.require(:rating)
  end
end
