class MoviesController < ApplicationController
  def list
    @movies = Movie.all
    render layout: "landing"
  end

  def show
    @movie = Movie.find(params[:id]).decorate
  end

  def new
    @movie = Movie.new
    @categories = Category.all.map &:title 
  end

  def create
    @movie = Movie.new movie_params
    if @movie.save
      redirect_to movie_path(@movie), notice: "Movie was successfully created."
    else
      render action: "new"
    end
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    
    if @movie.update movie_params
      redirect_to @movie, notice: "Movie was successfully updated."
    else
      render action: "edit"
    end
  end

  def destroy
    movie = Movie.find(params[:id]).destroy
    redirect_to :root
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :description, :rating, :category_id)
  end
end
