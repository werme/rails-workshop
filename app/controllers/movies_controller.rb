class MoviesController < ApplicationController
  def list
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
    @movie = Movie.new movie_params
    if @movie.save
      redirect_to movie_path(@movie), notice: "Movie was successfully added."
    else
      render action: "new"
    end
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
    category = params.require(:category)
    rating = params.require(:rating)

    @movies = Movie.by_category(category).by_rating(rating)
    render action: "list"
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :description, :rating, :category_id)
  end
end
