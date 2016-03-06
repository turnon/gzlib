require 'nokogiri'

class Book

  attr_reader :title

  def initialize(node)
    @title = node.at_css(".bookmetaTitle").text.gsub(/[\r\n\t]/,'')
  end
end
