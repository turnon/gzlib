class Search
  Search = 'http://opac.gzlib.gov.cn/opac/search?hasholding=1&searchWay=title&q='
 
  attr_reader :books, :pages

  def initialize(key)
    doc = getHTML "#{Search}#{escape key}"
    @books = doc.css(".bookmeta").map do |node|
               Book.new(node)
             end.to_a
    @pages = doc.at_css(".meneame .disabled").text.gsub(/[^\d]/,'').to_i
  end

  private

  def getHTML(url)
    Nokogiri::HTML(open url)
  end

  def escape(str)
    WEBrick::HTTPUtils.escape str.force_encoding('utf-8')
  end

end
