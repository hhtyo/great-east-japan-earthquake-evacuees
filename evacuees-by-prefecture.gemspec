# encoding: utf-8

require File.expand_path('../lib/evacuees/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'great-east-japan-earthquake-evacuees'
  gem.description   = gem.summary = 'Extract evacuees data from Recovery Agency PDF files'
  gem.version       = Evacuees::VERSION
  gem.authors       = ['Søren Jones']
  gem.email         = ['soren.jones@gmail.com']
  gem.homepage      = 'https://github.com/hhtyo/east-japan-earthquake-evacuees'
  gem.license       = 'Public Domain (Unlicense)'

  gem.platform      = 'java'

  gem.files         = `git ls-files | grep -Ev '^(data|test_data)'`.split("\n")
  gem.test_files    = `git ls-files -- test/*`.split("\n")
  gem.require_paths = ['lib']

  gem.add_dependency              'nokogiri'
  gem.add_dependency              'tabula-extractor'

  gem.add_development_dependency  'minitest'
  gem.add_development_dependency  'rake'
end
