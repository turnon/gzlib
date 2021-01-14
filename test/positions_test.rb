require 'minitest_helper'
require 'gzlib/positions'

class TestPositions < Minitest::Test

  def test_new
    poss = Gzlib::Positions.new 1978176
    assert 1 < poss.count
    loan_have_returndate = poss.select(&:loan?).all?{ |p| p.returnDate }
    assert loan_have_returndate
  end
end
