require "rubygems"
require File.expand_path(File.dirname(__FILE__) + "/weather")
require "spec"
require "fakeweb"
require "json"

# True lets it connect to live servers
FakeWeb.allow_net_connect = false

describe Weather do
  
  it "should create an instance" do
    Weather.new.should be_a_kind_of(Weather)
  end

end