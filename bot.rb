require 'slack-ruby-bot'
require_relative 'google_api/search.rb'

class Bot < SlackRubyBot::Bot

  def self.search_youtube
    youtube = Video.new
    search_result = youtube.search("nada surf") 
    
    return search_result.first
  end

  command 'ping' do |client, data, match|
    client.say(text: 'pong', channel: data.channel)
  end

  command 'ey' do |client,data,match|
    client.say(text: "https://www.youtube.com/watch?v=#{search_youtube}", channel: data.channel)
  end
end

Bot.run
