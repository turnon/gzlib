require 'json'
require 'gzlib/holding'

module Gzlib
  class Positions

    Search = 'http://opac.gzlib.gov.cn/opac/api/holding/'

    include Enumerable

    def initialize(id)
      fetch_json id
      merge_holding_loan
    end

    def each &b
      @holdings.each &b
    end

    private

    def json
      @json
    end

    def fetch_json id
      json_file = open "#{Search}#{id}"
      @json = JSON.parse json_file.read
    end

    def merge_holding_loan
      libcodeMap = json['libcodeMap']
      localMap = json['localMap']
      loanWorkMap = json['loanWorkMap']

      @holdings = json['holdingList'].map do |hold|
        h = Gzlib::Holding.new hold
        h.libcodeMap = libcodeMap
        h.localMap = localMap
        h.loan = loanWorkMap[h.barcode]
        h
      end
    end
  end
end
