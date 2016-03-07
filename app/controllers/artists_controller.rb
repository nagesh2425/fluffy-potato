class ArtistsController < ApplicationController
  before_action :set_artist, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @artists = Artist.all
    #respond_with(@artists)
    #to respond api call to get data in json format
    respond_to do |format|
        format.html {render action: 'index'}
        format.json {render json: @artists}
    end
  end

  def show
    respond_with(@artist)
  end

  def new
    @artist = Artist.new
    respond_with(@artist)
  end

  def edit
  end

  def create
    @artist = Artist.new(artist_params)
    @artist.save
    respond_with(@artist)
  end

  def update
    @artist.update(artist_params)
    respond_with(@artist)
  end

  def destroy
    @artist.destroy
    respond_with(@artist)
  end

  private
    def set_artist
      @artist = Artist.includes(:albums).where(id: params[:id]).first
    end

    def artist_params
      params.require(:artist).permit(:name)
    end
end
