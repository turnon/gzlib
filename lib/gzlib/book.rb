class Book

  Search = "http://opac.gzlib.gov.cn/opac/book/holdingpreview/"

  attr_reader :title, :id

  def initialize(node)
    @title = node.at_css(".bookmetaTitle").text.gsub(/[\r\n\t]/,'')
    @id = node['bookrecno']
  end

  def positions
    @poss ||= getXML.css('record').map{|rec| Position.new rec}
  end

  private

  def getXML
    Nokogiri::XML(open "#{Search}#{id}")
  end
end
