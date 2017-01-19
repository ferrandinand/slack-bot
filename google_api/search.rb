#!/usr/bin/ruby

require 'rubygems'
gem 'google-api-client', '>0.7'
require 'google/api_client'
require 'trollop'

DEVELOPER_KEY = ''
YOUTUBE_API_SERVICE_NAME = 'youtube'
YOUTUBE_API_VERSION = 'v3'


class Video
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

  def initialize

   @client, @youtube = get_service
  end 

  def search(text_search="bot",max_results=1)
     search_response = @client.execute!(
       :api_method => @youtube.search.list,
       :parameters => {
         :part => 'snippet',
         :q => text_search, 
         :maxResults => max_results
       }
     )

    videos = []
    search_response.data.items.each do |search_result|
      if search_result.id.kind == 'youtube#video'
        videos << search_result.id.videoId
      end
    end

    return videos

  end
end
