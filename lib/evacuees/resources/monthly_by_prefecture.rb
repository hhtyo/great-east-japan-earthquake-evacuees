# encoding: utf-8

require_relative 'csv_resource'

module Evacuees
  class MonthlyByPrefecture < CSVResource
    class << self
      def name
        'monthly-by-prefecture'
      end

      def fields
        [
          {
            name: '都道府県コード',
            type: 'string',
            description: 'ISO 3166-2：JPコード'
          }, {
            name: '都道府県名',
            type: 'string'
          }, {
            name: '計',
            type: 'number'
          }, {
            name: '年月日',
            type: 'date'
          }
        ]
      end

      def header
        fields.collect { |field| field[:name] }
      end
    end

    def transform_data(raw_data)
      indexes = get_indexes(raw_data.date)

      raw_data.body.map do |row|
        row.select.with_index { |_, idx| indexes.include?(idx) }
      end
    end

    private

    def get_indexes(date)
      date < Date.new(2014,2,13) ? [0, 1, 6, 9] : [0, 1, 5, 8]
    end
  end
end
