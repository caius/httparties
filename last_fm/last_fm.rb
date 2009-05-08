require "rubygems"
require "httparty"

class LastFM
  class MissingAPIKey < Exception; end
  class MissingSecret < Exception; end
  
  attr_reader :api_key, :secret
  
  include HTTParty
  
  base_uri "http://ws.audioscrobbler.com/2.0/"
  format :xml
  
  def initialize opts={}
    @api_key = opts[:key]
    @secret  = opts[:secret]
  end
    
  def latest_track_for( user )
    r = self.class.get("", :query => {:method => "user.getrecenttracks", :limit => 1, :user => user}.merge(auth_params))
  end
  
  protected
  
  def auth_params
    o = {}
    o[:api_key] = @api_key
    o[:secret] = @secret unless @secret.nil?
    o
  end
  
end
