require 'gzlib/positions'

module Gzlib
  class Book

    Search = 'http://opac.gzlib.gov.cn/opac/book/holdingpreview/'

    attr_reader :title, :id, :author, :publisher, :year

    def initialize(node)
      @title = node.at_css('.bookmetaTitle').text.strip
      @id = node['bookrecno']
      metas = node.css('div')
      @author = metas[1].at_css('a').text.strip
      @publisher = metas[2].at_css('a').text.strip
      @year = metas[2].text.gsub(/[^\d]/,'')
    end

    def positions
      @poss ||= Gzlib::Positions.new id
    end
  end
end
