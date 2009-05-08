require "rubygems"
require "httparty"

class ManlyLiving
  include HTTParty

  base_uri "http://api.manlyliving.org"

  def self.latest
    normalise(get("/fetch/latest")['rules']['rule'])
  end

  def self.random
    normalise(get("/fetch/random")['rules']['rule'])
  end

  private

  # This is here because the API sometimes returns escaped 's.
  def self.normalise hash={}
    hash["content"] = hash["content"].gsub(/\\'/, "'")
    hash
  end

end

__END__

ManlyLiving.latest # => {"timestamp"=>"2009-05-07 17:47:57", "id"=>"63", "content"=>"We don't pee whilst sitting down."}
ManlyLiving.random # => {"timestamp"=>"2009-04-02 20:39:12", "id"=>"17", "content"=>"When stumbling upon other guys watching a sports event, you may always ask the score of the game in progress, but you may never ask who's playing."}
