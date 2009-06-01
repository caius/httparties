require "rubygems"
require "httparty"

class Weather
  include HTTParty
  
  attr_accessor :humidity, :condition, :temp
  
  def initialize
    yield(self) if block_given?
    @temp ||= {}
  end
  
  base_uri "http://www.google.com/ig/api"
  
  def self.find location
    r = get("", :query => {:weather => location})["xml_api_reply"]["weather"]["current_conditions"]
    
    Weather.new do | w |
      w.humidity  = r["humidity"]["data"]
      w.condition = r["condition"]["data"]
      w.temp = {
        :c => r["temp_c"]["data"],
        :f => r["temp_c"]["data"]
      }
    end
  end
  
  def to_s
    "Currently #{condition} at #{@temp[:c]}°C (#{temp[:f]}°f) #{humidity} humidity"
  end
  
end

if $0 == __FILE__
  puts Weather.find("Leeds, UK").to_s
end
