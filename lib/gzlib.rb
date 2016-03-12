require 'open-uri'
require 'nokogiri'
require 'webrick/httputils'
require "gzlib/version"
require "gzlib/search"
require "gzlib/position"
require "gzlib/book"

module Gzlib
  class << self
    def search(*para)
      Search.new(*para)
    end

    def list(*para)
      Style[search *para]
    end
  end

  Style = Proc.new do |search|
    search.first(10).map do |book|
      Book[book]
    end.join "\n\n"
  end

  Book = Proc.new do |book|
    "#{book.title} #{book.author}\n#{book.publisher} #{book.year}\n#{Poss[book.positions]}"
  end

  Poss = Proc.new do |poss|
    if poss.empty?
      "#{Ind}N/A\n"
    else
      poss.map do |pos|
        "#{Ind}#{pos.callno} #{pos.curlibName} #{pos.curlocalName} #{pos.copycount}"
      end.join "\n"
    end
  end

  Ind = "    "
end
