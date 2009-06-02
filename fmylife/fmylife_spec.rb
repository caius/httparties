require "rubygems"
require File.expand_path(File.dirname(__FILE__) + "/fmylife")
require "spec"
require "fakeweb"
require "json"

# True lets it connect to live servers
FakeWeb.allow_net_connect = false

describe FMyLife do
  
  it "should create an instance" do
    Blank.new.should be_a_kind_of(Blank)
  end

end