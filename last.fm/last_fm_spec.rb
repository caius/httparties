require "rubygems"
require "last_fm"
require "spec"
require "fakeweb"
require "json"


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
      @lfm.latest_track_for("caiusd").should == nil
    end
    
  end
  
end