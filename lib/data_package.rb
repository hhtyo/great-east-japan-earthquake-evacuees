# encoding: utf-8

require 'json'

class DataPackage
  # Creates a stub datapackage hash.
  def initialize(name)
    @datapackage = {}
    @datapackage[:name] = name
  end

  def add_title(title)
    @datapackage[:title] = title

    self
  end

  def add_license(license)
    @datapackage[:license] = license

    self
  end

  def add_keywords(keywords)
    @datapackage[:keywords] = keywords

    self
  end

  def add_source(source)
    @datapackage[:sources] ||= []
    @datapackage[:sources].push(source)

    self
  end

  def add_resource(resource)
    @datapackage[:resources] ||= []
    @datapackage[:resources].push(resource)

    self
  end

  def add_view(view)
    @datapackage[:views] ||= []
    @datapackage[:views].push(view)

    self
  end

  def to_json
    JSON.pretty_generate(@datapackage)
  end
end
