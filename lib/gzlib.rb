require 'gzlib/version'
require 'gzlib/search'

module Gzlib
  class << self
    def search(*para)
      Search.new(*para)
    end

    def list(*para)
      style search(*para)
    end

    private

    def style search
      search.first(10).map do |book|
        book_style book
      end.join "\n\n"
    end

    def book_style book
      "#{book.title} #{book.author}\n#{book.publisher} #{book.year}\n#{position_style book.positions}"
    end

    def position_style poss
      free = poss.
        reject(&:loan?).
        group_by(&:callno).
        map{|callno, poss| [callno, "free x #{poss.count}"]}

      loan = poss.
        select(&:loan?).
        sort_by(&:returnDate).
        map{|pos| [pos.callno, pos.returnDate]}

      (free + loan).map{|status| status.join(' ')}.join("\n")
    end

  end

end
