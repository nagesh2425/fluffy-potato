require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html
  before_action :get_latest_five_songs
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  #method to get latest 5 songs to display in footer
  def get_latest_five_songs
      @latest_songs = Song.recent(5)
  end
  
end
