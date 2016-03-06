require 'open-uri'
require 'nokogiri'
require 'webrick/httputils'
require "gzlib/version"
require "gzlib/search"
require "gzlib/book"

module Gzlib
  def self.search(key)
    Search.new(key)
  end
end
