class PlaylistSongsController < ApplicationController

  def new

  end

  def create

  end

  def edit
    #Adding the mood
    @playlist_song = PlaylistSong.find(params[:id])
    # @user = User.find(params[:user_id])
    @user_id = params[:user_id]
    #find the user, using the user id in params hash
  end

  def update
    @playlist_song = PlaylistSong.find(params[:id])
    @playlist_song.update(mood: params[:mood])
    @playlist = Playlist.find(params[:playlist_id])
    moods =  @playlist.playlist_songs.map do |ps|
        ps.mood
      end
    @playlist.mood = moods.inject{ |sum, el| sum + el } / moods.size
    @playlist.save

    redirect_to "/users/#{params[:user_id]}/playlists/#{@playlist_song.playlist.id}"
  end

  def show

  end
end
