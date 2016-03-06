require "gzlib/version"
require "gzlib/search"

module Gzlib
  def self.search(key)
    Search.new(key)
  end
end
