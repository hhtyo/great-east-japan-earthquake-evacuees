# encoding: utf-8

require 'yaml'
require 'nokogiri'
require 'open-uri'
require 'uri'

class DataSources
  include Enumerable

  attr_reader :current_urls

  def initialize(yaml_path)
    @yaml_path = yaml_path
    @current_urls = read_yaml
  end

  def update(url, xpath)
    scraped_urls = scrape_urls(url, xpath)
    new_urls = find_new_urls(scraped_urls)

    unless new_urls.empty?
      yaml = new_urls.to_yaml[4..-1] # strip the leading `---\n`
      write_yaml(yaml)
      @current_urls = read_yaml
    end

    self
  end

  def each(&block)
    @current_urls.each(&block)
  end

  private

  def read_yaml
    YAML.load_file(@yaml_path)
  end

  def write_yaml(yaml)
    File.open(@yaml_path, 'a') { |file| file.write yaml }
  end

  def scrape_urls(url, xpath)
    base_url = parse_base_url(url)
    relative_paths = scrape_relative_paths(url, xpath)
    relative_paths.map { |path| "#{base_url}#{path}" }
  end

  def parse_base_url(url)
    parsed_url = URI.parse(url)
    "#{parsed_url.scheme}://#{parsed_url.host}"
  end

  def scrape_relative_paths(url, xpath)
    items = scrape_items(url, xpath)
    items.reject { |item| /^\/.*/ !~ item }
  end

  def scrape_items(url, pattern)
    page = Nokogiri::HTML(open(url))
    page.xpath(pattern).map { |value| value.to_s }
  end

  def find_new_urls(urls)
    urls.reject { |url| @current_urls.include? url }
  end
end
