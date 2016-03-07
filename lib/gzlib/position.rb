class Position
  attr_reader :callno, :curlib, :curlibName, :curlocal, :curlocalName, :copycount
  def initialize(node)
    node.children.map do |elem|
      instance_variable_set "@#{elem.name}", elem.text
    end
  end
end
