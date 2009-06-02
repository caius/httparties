require "rubygems"
require File.expand_path(File.dirname(__FILE__) + "/google")
require "spec"
require "fakeweb"
require "json"

# True lets it connect to live servers
FakeWeb.allow_net_connect = false

describe Google do
  
  it "should create an instance" do
    Google.new.should be_a_kind_of(Google)
  end
  
  it "should find results" do
    FakeWeb.register_uri(:get, "http://ajax.googleapis.com:80/ajax/services/search/web?q=search-term&v=1.0", :file => File.dirname(__FILE__) + "/google.json")
    
    r = Google.find("search-term")
    
    r.should be_a_kind_of(Array)
    r.each do | res |
      res.should be_a_kind_of(Google)
    end
  end
  
  describe "attributes" do
    
    before(:each) do
      @g = Google.new
    end
    
    it "should have a title" do
      @g.title = "title"
      
      @g.title.should == "title"
    end
    
    it "should have a raw_title" do
      @g.raw_title = "raw title"
      
      @g.raw_title.should == "raw title" 
    end
    
    it "should have a url" do
      @g.url = "url"
      
      @g.url.should == "url"
    end
    
    it "should have a cache_url" do
      @g.cache_url = "cache url"
      
      @g.cache_url.should == "cache url"
    end
    
    it "should have a raw url" do
      @g.raw_url = "raw url"
      
      @g.raw_url.should == "raw url"
    end
    
    it "should have content" do
      @g.content = "content"
      
      @g.content.should == "content"
    end
  end
  
end