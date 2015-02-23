# encoding: utf-8

class CSVResource
  class << self
    def name
      'csv-resource'
    end

    def fields
      []
    end

    def header; end
  end

  attr_accessor :path, :data, :metadata

  def initialize(dir)
    @dir = dir
    @name = self.class.name
    @fields = self.class.fields
    @path = File.expand_path("#{@name}.csv", dir)
    @data = []
  end

  def metadata
    {
      name: @name,
      path: "#{@dir}/#{@name}.csv",
      format: 'csv',
      mediatype: 'text/csv',
      schema: { fields: @fields }
    }
  end

  def add_data(new_data)
    transformed_data = transform_data(new_data)

    data.concat(transformed_data)

    self
  end

  def sort
    @data.sort_by! { |row| row[-1] }

    self
  end

  def transform_data(raw_data)
    raw_data
  end

  def to_csv(opts = { header: true })
    CSV.generate do |csv|
      csv << self.class.header
      @data.each { |row| csv << row }
    end
  end
end
