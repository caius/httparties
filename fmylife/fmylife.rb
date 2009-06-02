require "rubygems"
require "httparty"

# Queries the wwww.fmylife.com API for data
# Written by Caius Durling
# Released under the WTFPL licence (See DATA)
class FMyLife
  include HTTParty
  Version = 0.1
  
  base_uri "http://api.betacie.com/view"
  default_params :key => "readonly", :language => "en"
  format :xml
  
  # Return the 15 fml's from this page
  # param: (integer) page number [optional]
  def self.page num = 1
    get("/last/#{num}")["root"]["items"]["item"]
  end
  
  # Return the fml of this id
  # param: (integer) fml id
  def self.show id
    get("/#{id}/nocomment")["root"]["items"]["item"]
  end
  
  # Return the fml of this id and comments
  # param: (integer) fml id
  def self.show_with_comments id
    r = get("/#{id}")
    r["root"]["items"]["item"].merge({:comments => r["root"]["comments"]})
  end
  
  # Return a random FML
  def self.random
    get("/random")["root"]["items"]["item"]
  end
  
  # Return an array of category names
  def self.categories
    get("/categories")["root"]["categories"]["categorie"]
  end
  
  # Return a pageful of fml's from specified category
  # param: (string) category name
  # param: (integer) page number [optional]
  def self.category name, page = 1
    get("/view/#{name}")
  end
  
  # Return all matching FMLs for the search query
  # NB: Appears to return everything if nothing matches.
  # param: (string) search term
  def self.search terms
    post("/search", :query => {:search => terms})["root"]["items"]["item"]
  end
      
end

__END__
This program is free software. It comes without any warranty, to
the extent permitted by applicable law. You can redistribute it
and/or modify it under the terms of the Do What The Fuck You Want
To Public License, Version 2, as published by Sam Hocevar. See
http://sam.zoy.org/wtfpl/COPYING for more details.