class PlaylistsController < ApplicationController

  def new
    @playlist = Playlist.new(title: params[:title], user_id: params[:user_id])
    @playlist.save
    
  end

  def create

  end

  def search
    #enter api stuff
    #once found, Song.find_or_create_by(the song)
    #create playlist_song with self.id and the song_id
    #prompt to enter mood? so a redirect_to a mood action?
    #once the song is added, we redirect_to the new page, which will have the search form and a button to stop adding songs
  end

  def show

  end

end
