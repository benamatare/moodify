module ApplicationHelper
   require 'rubygems'
   require 'google/api_client'
   require 'trollop'

  def login?
    if session[:user_id]
      true
    else
      false
    end
  end














#youtube search stuff
DEVELOPER_KEY = 'AIzaSyDXvv8XUM7amNwkw_LD9lXwZUstWcVO0xw'
YOUTUBE_API_SERVICE_NAME = 'youtube'
YOUTUBE_API_VERSION = 'v3'
  def get_service
    client = Google::APIClient.new(
     :key => DEVELOPER_KEY,
     :authorization => nil,
     :application_name => $PROGRAM_NAME,
     :application_version => '1.0.0'
   )
   youtube = client.discovered_api(YOUTUBE_API_SERVICE_NAME, YOUTUBE_API_VERSION)

   return client, youtube
  end

  def search_youtube(search_term)
    opts = Trollop::options do
    opt :q, 'search_term', :type => String, :default => search_term
    opt :max_results, 'Max results', :type => :int, :default => 1
    end

    client, youtube = get_service

    begin
      # Call the search.list method to retrieve results matching the specified
      # query term.
      search_response = client.execute!(
        :api_method => youtube.search.list,
        :parameters => {
          :part => 'snippet',
          :q => opts[:q],
          :maxResults => opts[:max_results]
        }
      )

    videos = []

    # Add each result to the appropriate list, and then display the lists of
    # matching videos, channels, and playlists.
    search_response.data.items.each do |search_result|
      case search_result.id.kind
        when 'youtube#video'
          videos << "#{search_result.snippet.title} (#{search_result.id.videoId})"
      end
    end

    # puts "Videos:\n", videos, "\n"

    rescue Google::APIClient::TransmissionError => e
      puts e.result.body
    end

    videoId = videos[0][-12..-2]
  end

end
