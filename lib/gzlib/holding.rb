require 'ostruct'

module Gzlib
  class Holding < OpenStruct

    attr_accessor :loan, :libcodeMap, :localMap
    attr_reader :info

    def loan?
      !!@loan
    end

    def returnDate
      Time.at loan['returnDate'] / 1000 if loan?
    end

    def curlibname
      libcodeMap[curlib]
    end

    def curlocalname
      localMap[curlocal]
    end

    def lib_callno
      [curlibname, curlocalname, callno].join ' '
    end

  end
end
