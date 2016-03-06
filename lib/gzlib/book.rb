require 'nokogiri'

class Book

  attr_reader :title, :id

  def initialize(node)
    @title = node.at_css(".bookmetaTitle").text.gsub(/[\r\n\t]/,'')
    @id = node['bookrecno']
  end
end
