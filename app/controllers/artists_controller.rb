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
    if @artist.image_url.blank?
      image_url = update_image(@artist)
      @artist.update_attribute(:image_url, image_url.gsub("\"","").strip)
    end
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
    redirect_to artists_path
  end

  def update
    @artist.update(artist_params)
    respond_with(@artist)
  end

  def destroy
    @artist.destroy
    respond_with(@artist)
  end

#method to get the image url from randomuser website
  def update_image(artist)
    uri = URI("https://randomuser.me/api/")
    Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
        request = Net::HTTP::Get.new uri
        response = http.request request # Net::HTTPResponse object
        return JSON.parse(response.body)["results"][0]["user"]["picture"]["thumbnail"].inspect
    end
  end
  
  private
    def set_artist
        @artist = Artist.includes(:albums).where(id: params[:id]).first
    end

    def artist_params
      params.require(:artist).permit(:name)
    end
end
