require 'minitest_helper'
require 'gzlib'

class TestGzlib < Minitest::Test

  def setup
    @ruby = Gzlib.search 'ruby', rows: 10
    @score_ruby = Gzlib.search 'ruby', sortWay: 'score'
    @matz_ruby = Gzlib.search '9787115366467', searchWay: 'isbn'
  end

  def test_has_ruby_book
    assert_match /^ruby/i, @score_ruby.first.title
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

  def test_one_isbn_one_book
    assert @matz_ruby.map{|b| b.title}.uniq.size == 1
  end
end
