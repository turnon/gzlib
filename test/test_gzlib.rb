require 'minitest_helper'
require 'gzlib'

class TestGzlib < Minitest::Test

  def setup
    @ruby = Gzlib.search 'ruby'
  end

  def test_has_ruby_book
    assert_match /^ruby/i, @ruby.first.title
  end

  def test_ruby_has_10_pages_more_result
    assert @ruby.pages > 10
  end

  def test_has_book_id
    assert (not @ruby.first.id.nil?)
  end

  def test_can_fetch_book_in_next_page
    assert @ruby.any?{|book| book.title.match /My true story/}
    assert @ruby.curPage > 1
  end

  def test_can_fetch_books_until_last_page
    assert @ruby.total > 100
    assert @ruby.lastPage?
  end
end
