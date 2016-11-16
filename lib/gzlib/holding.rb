require 'ostruct'

module Gzlib
  class Holding < OpenStruct

    attr_accessor :loan
    attr_reader :info

    def loan?
      !!@loan
    end

    def returnDate
      Time.at loan['returnDate'] / 1000 if loan?
    end
  end
end
