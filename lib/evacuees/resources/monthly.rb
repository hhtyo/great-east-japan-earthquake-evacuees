# encoding: utf-8

require_relative 'csv_resource'

module Evacuees
  class Monthly < CSVResource
    class << self
      def name
        'monthly'
      end

      def fields
        [
          {
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
      total_index = get_index(raw_data.date)

      total = raw_data.body.inject(0) do |sum, row|
        row[total_index] == 'NA' ? sum : sum + row[total_index].to_i
      end

      [[total, raw_data.date]]
    end

    private

    def get_index(date)
      date < Date.new(2014,02,13) ? 6 : 5
    end
  end
end
