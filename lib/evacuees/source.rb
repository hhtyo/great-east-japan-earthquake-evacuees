# encoding: utf-8

require 'net/http'
require 'csv'
require 'date'

module Evacuees
  class Source
    class << self
      def name
        'Reconstruction Agency'
      end

      def web
        'http://www.reconstruction.go.jp/topics/main-cat2/sub-cat2-1/hinanshasuu.html'
      end

      def metadata
        {
          name: name,
          web: web
        }
      end

      def xpath
        "//ul[@class='mt5'][1]/li/a/@href"
      end
    end

    attr_reader :name, :data, :pdf_path, :csv_path

    def initialize(url, dir)
      @url = url
      @name = File.basename(url.split('/').last, '.*')
      @pdf_path = File.expand_path("#{@name}.pdf", "#{dir}/pdf")
      @csv_path = File.expand_path("#{@name}.csv", "#{dir}/csv")
    end

    def download
      unless File.file?(@pdf_path)
        File.write(@pdf_path, Net::HTTP.get(URI.parse(@url)))
      end

      self
    end

    def extract(extractor)
      if File.file?(@csv_path)
        # TODO:
        # Figure out why CSV.read() is choking on characters.
        csv = CSV.parse(File.read(@csv_path))
        @data = ExtractedSource.new(csv)
      else
        @data = extractor.extract
        File.write(@csv_path, to_csv)
      end

      self
    end

    def to_csv(opts = { header: true })
      CSV.generate do |csv|
        csv << @data.header if opts[:header]
        @data.body.each { |row| csv << row }
      end
    end

    ExtractedSource = Struct.new(:csv) do
      def header
        csv[0]
      end

      def body
        csv[1..-1]
      end

      def date
        Date.parse(csv[1][-1])
      end
    end
  end
end
