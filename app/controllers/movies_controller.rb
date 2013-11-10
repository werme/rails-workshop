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
    if movie.update movie_params
      redirect_to movie_path movie, notice: "Movie was successfully updated."
    else
      render action: "edit"
    end
  end

  def filter
    @movies = Movie.by_category(params[:category]).by_rating(params[:rating])
    render action: "list"
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :description, :rating, :category_id)
  end
end
