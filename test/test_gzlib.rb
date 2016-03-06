require 'minitest_helper'
require 'gzlib'

class TestGzlib < Minitest::Test

  def setup
    @ruby = Gzlib.search 'ruby'
  end

  def test_has_ruby_book
    assert_match /^ruby/i, @ruby.books.first.title
  end

  def test_ruby_has_10_pages_more_result
    assert @ruby.pages > 10
  end

  def test_has_book_id
    assert (not @ruby.books.first.id.nil?)
  end
end
