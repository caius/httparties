require "rubygems"
require "httparty"

class Google
  include HTTParty
  
  base_uri "http://ajax.googleapis.com/ajax/services/search/web"
  default_params :v => 1.0
  format :json
  
  attr_accessor :title, :raw_title,
                :url, :raw_url, :cache_url,
                :content
  
  def initialize &block
    yield(self) if block_given?
  end
  
  def self.find terms
    results = []
    get("", :query => {:q => terms})["responseData"]["results"].each do | result |
      results << Google.new do | s |
        s.title     = result["titleNoFormatting"]
        s.raw_title = result["title"]
        s.url       = result["url"]
        s.raw_url   = result["unescapedUrl"]
        s.cache_url = result["cacheUrl"]
        s.content   = result["content"]
      end
    end
    results
  end
  
end

if $0 == __FILE__
  p Search.find("caius durling").map {|x| x.title }
end
