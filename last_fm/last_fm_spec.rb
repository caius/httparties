require "rubygems"
require File.expand_path(File.dirname(__FILE__) + "/last_fm")
require "spec"
require "fakeweb"
require "json"

# True lets it connect to live servers
FakeWeb.allow_net_connect = false

describe LastFM do

  it "should create with api key" do
    l = LastFM.new(:key => "api_key")

    l.api_key.should == "api_key"
  end

  it "should create with api key and secret" do
    l = LastFM.new(:key => "api key", :secret => "sekrets")

    l.api_key.should == "api key"
    l.secret.should == "sekrets"
  end

  describe "api calls" do

    before(:each) do
      @lfm = LastFM.new(:key => "api key", :secret => "sekrets")
    end

    it "should return the latest played songs for a user" do
      FakeWeb.register_uri(:get, %r{\Ahttp://ws.audioscrobbler.com/2.0/.*\z}, :string => "response string")

      @lfm.latest_track_for("caiusd").should == nil
    end

  end

end