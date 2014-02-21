class MoviesController < ApplicationController
  def list
    @movies = Movie.all

    # Specify layout when neccessary.
    # Defaults to app/views/layouts/application.html.erb.
    render layout: "landing"
  end

  def show
    # Use decorators for presentational logic on the model. 
    # Go check out the draper gem.
    @movie = Movie.find(params[:id]).decorate
  end

  def new
    @movie = Movie.new
    @categories = Category.all.map &:title 
  end

  def create
    @movie = Movie.new movie_params
    
    if @movie.save
      # Send flash messages to your views through the flash object
      # or as arguments to redirect_to.
      flash[:alert] = "Tried to fetch additional information from omdb, please edit if incorrect." if @movie.year.present?
      
      redirect_to movie_path(@movie), notice: "Movie was successfully created."
    else
      # Use render over redirect to keep @movie with errors 
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
    params.require(:movie).permit(:title, :description, :rating, :year, :poster_uri, :category_id)
  end
end
