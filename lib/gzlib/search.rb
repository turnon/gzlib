class Search
  Search = 'http://opac.gzlib.gov.cn/opac/search?hasholding=1&searchWay=title&'
 
  attr_reader :books, :pages

  include Enumerable

  def initialize(key)
    @para = {q: escape(key), page: 1}
    doc = getHTML
    @books = getBooks(doc)
    @pages = doc.at_css(".meneame .disabled").text.gsub(/[^\d]/,'').to_i
  end

  def each(&b)
    @books.each &b
    while not lastPage?
      nextPage
      books = getBooks(getHTML)
      @books.concat books
      books.each &b
    end
  end

  def total
    reduce(0){|sum, book| sum + 1}
  end

  def curPage
    @para[:page]
  end

  def lastPage?
    curPage == pages
  end

  private

  def getHTML
    Nokogiri::HTML(open "#{Search}#{para}")
  end

  def escape(str)
    WEBrick::HTTPUtils.escape str.force_encoding('utf-8')
  end

  def para
    @para.map{|k,v| "#{k}=#{v}"}.join('&')
  end

  def getBooks(doc)
    doc.css(".bookmeta").map do |node|
      Book.new(node)
    end.to_a
  end

  def nextPage
    @para.merge!({page: curPage+1})
  end

end
