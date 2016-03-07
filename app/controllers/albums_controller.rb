class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy]
  before_action :find_publishers, only: [:edit, :update, :create, :new]
  respond_to :html

  def index
    @albums = Album.all
    #respond_with(@albums)
    
    #to respond api call to get data in json format
    respond_to do |format|
      format.html {render action: 'index'}
      format.json {render json: @albums}
    end
  end

  def show
    respond_with(@album)
  end

  def new
    @album = Album.new
    respond_with(@album)
  end

  def edit
  end

  def create
    @album = Album.new(album_params)
    @album.save
    respond_with(@album)
  end

  def update
    @album.update(album_params)
    respond_with(@album)
  end

  def destroy
    @album.destroy
    #respond_with(@album)
    respond_to do |format|
      format.js
    end
  end

  private
    def set_album
        @album = Album.includes(:songs).where(id: params[:id]).first
    end

    def album_params
      params.require(:album).permit(:name, :cover_art, :publisher_id, :released_on)
    end
    
    #method to find the publishers
    def find_publishers
      @publishers = Publisher.pluck(:id, :name)
    end
end
