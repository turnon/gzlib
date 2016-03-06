class Search
  @@url = 'http://opac.gzlib.gov.cn/opac/search?hasholding=1&searchWay=title&q='
 
  attr_reader :result, :pages

  def initialize(key)
    doc = getHTML "#{@@url}#{escape key}"
    @result = doc.css(".bookmeta").map do |node|
                Book.new(node).title
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
