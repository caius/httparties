require "rubygems"
require "httparty"

class Search
  include HTTParty
  
  base_uri "http://ajax.googleapis.com/ajax/services/search/web"
  default_params :v => 1.0
  
  attr_accessor :title, :url, :content
  
  def initialize &block
    yield(self) if block_given?
  end
  
  def self.find terms
    results = []
    get("", :query => {:q => terms})["responseData"]["results"].each do | result |
      results << Search.new do | s |
        s.title   = result["titleNoFormatting"]
        s.url     = result["url"]
        s.content = result["content"]
      end
    end
    results
  end
  
end

if $0 == __FILE__
  p Search.find("caius durling").map {|x| x.title }
end

