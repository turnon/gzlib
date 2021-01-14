require 'webrick/httputils'
require 'nokogiri'
require 'net/http'
require 'gzlib/book'

module Gzlib
  class Search
    Search = 'http://opac.gzlib.gov.cn/opac/search?hasholding=1&'
    Para = {page: 1, searchWay: 'title', sortWay: 'title200Weight', rows: 100, curlibcode: 'GT'}
    AcceptableSearchWay = [:title, :marc, :isbn, :author, :subject, :class, :publish, :callno]

    attr_reader :pages

    include Enumerable

    class << self
      def method_missing search_way, *keywords, &blk
        opt = {searchWay: search_way}
        opt.merge! keywords.pop if keywords[-1].is_a? Hash
        return new(keywords.join(' '), opt) if AcceptableSearchWay.include? search_way
        super
      end
    end

    def initialize(key, opt={})
      @para = Para.merge({q: escape(key)}).merge opt
      doc = getHtml
      @books = getBooks(doc)
      @pages = (@books.empty? ? 1 : getPages(doc))
    end

    def [](i)
      @books[i]
    end

    def each(&b)
      @books.each &b
      while not lastPage?
        nextPage
        books = getBooks(getHtml)
        @books.concat books
        books.each &b
      end
    end

    def total
      reduce(0){ |sum, book| sum + 1 }
    end

    def curPage
      @para[:page]
    end

    def lastPage?
      curPage == pages
    end

    private

    def getHtml
      html = Net::HTTP.get(URI("#{Search}#{para}"))
      Nokogiri::HTML(html)
    end

    def escape(str)
      WEBrick::HTTPUtils.escape str.force_encoding('utf-8')
    end

    def para
      @para.map{ |k,v| "#{k}=#{v}" }.join('&')
    end

    def getBooks(doc)
      doc.css(".bookmeta").map do |node|
        Gzlib::Book.new(node)
      end.to_a
    end

    def getPages(doc)
      doc.at_css(".meneame .disabled").text.gsub(/[^\d]/,'').to_i
    end

    def nextPage
      @para.merge!({page: curPage+1})
    end

    def open(str)
      Net::HTTP.get(URI(str))
    end

  end
end
