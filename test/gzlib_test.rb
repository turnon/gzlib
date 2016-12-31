require 'minitest_helper'
require 'gzlib'

class TestGzlib < Minitest::Test

  def test_has_ruby_book
    score_ruby = Gzlib.search 'ruby', sortWay: 'score'
    assert_match /^ruby/i, score_ruby.first.title
  end

  def test_one_isbn_one_book
    matz_ruby = Gzlib.search '9787115366467', searchWay: 'isbn'
    assert_equal 1, matz_ruby.count
  end

  def test_convenient_method
    matz_ruby = Gzlib::Search.isbn '9787115366467'
    assert_equal 1, matz_ruby.count
  end

  def test_convenient_method_accept_options_not_just_keyword
    ruby_books = Gzlib::Search.send :title, 'ruby', rows: 500
    assert 100 < ruby_books.count
    assert_equal 1, ruby_books.curPage
  end

  def test_pages
    @ruby = Gzlib.search 'ruby', rows: 10
    has_10_pages_more_result
    has_book_id
    can_fetch_book_in_next_page
    can_fetch_books_until_last_page
  end

  private

  def has_10_pages_more_result
    assert @ruby.pages > 10
  end

  def has_book_id
    assert (not @ruby.first.id.nil?)
  end

  def can_fetch_book_in_next_page
    assert @ruby.any?{ |book| book.title.match /My true story/ }
    assert @ruby.curPage > 1
  end

  def can_fetch_books_until_last_page
    assert @ruby.total > 100
    assert @ruby.lastPage?
  end
end
