class PlaylistsController < ApplicationController
  before_action :call_login?, only: [:show]


  def create
    @playlist = Playlist.new(title: params[:title], user_id: params[:user_id])
    # byebug
    if !@playlist.valid?
      redirect_to user_path(params[:user_id])
    else
      @playlist.save
      redirect_to edit_user_playlist_path(@playlist.user_id, @playlist)
    end

  end

  def edit
    @playlist = Playlist.find(params[:id])
  end

  def search
    #enter api stuff
    #once found, Song.find_or_create_by(the song)
    #create playlist_song with self.id and the song_id
    #prompt to enter mood? so a redirect_to a mood action?
    #once the song is added, we redirect_to the new page, which will have the search form and a button to stop adding songs
    Yt.configuration.api_key = "AIzaSyDXvv8XUM7amNwkw_LD9lXwZUstWcVO0xw"
    videoId = helpers.search_youtube(params[:song_and_artist])
      #take me to that temp song#show page
    song = Song.find_or_create_by(video_id: videoId)
    # byebug
    playlist_song = PlaylistSong.create(playlist_id: params[:playlist_id], song_id: song.id)
      redirect_to edit_user_playlist_playlist_song_path(user_id: params[:user_id], playlist_id: params[:playlist_id],id: playlist_song.id)

    #at this step, we route them to a page that just has the youtubevideo, they listen to the song, and then if
    #if they want to add it to their playlist, prompt them to set a mood, and then create PlaylistSong and go forward
    # video = Yt::Video.new id: videoId
    #
    # byebug
    # # if video.category_title != "Music"
    # #   redirect_to edit_user_playlist_path(params[:user_id], params[:id])
    # # end
    # redirect_to edit_user_playlist_path(params[:user_id], params[:id])
  end

  def show
    @playlist = Playlist.find(params[:id])
    # moods =  @playlist.playlist_songs.map do |ps|
    #     ps.mood
    #   end
    # @sadboi_rating = moods.inject{ |sum, el| sum + el }.to_f / moods.size

    if session[:user_id] == @playlist.user_id
      @owner_homepage  = true
    else
      @owner_homepage = false
    end
  end

  def search_by_mood
    @playlists = Playlist.where(mood: params[:mood])
  end

  def destroy
    playlist = Playlist.find(params[:id])
    playlist.destroy
    redirect_to user_path(params[:user_id])
  end

private
  def call_login?
    if helpers.login? == false
      redirect_to '/'
    end
  end
end
