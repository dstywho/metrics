require 'rubygems'
require 'addressable/uri'
require 'open-uri'
require 'SonarConfig'
require 'yaml'

class SonarApi
  URI = Addressable::URI.parse "http://nemo.sonarsource.org/api/"

  def self.config
    f = File.new(Rails.root + "config/sonar.yml")
    raise "config file missing" unless File.exists? f
    SonarConfig.from_yaml f
  end

  def self.url(path, options={:format => 'json'})
    options ||= {:format => 'json' }
    options[:format] = 'json' if options[:format].nil?
  
    url = Addressable::URI.parse(config.api_uri).join path.to_s
    url.query_values = options
    url.to_s
  end

  def self.http_get(path,options={})
    puts url(path,options)
    open(url(path, options), :http_basic_authentication => config.http_basic_authentication).readlines[0]
  end

  def self.metrics(options={})
    http_get(:metrics,options)
  end

  def self.resources(options={})
    http_get(:resources,options)
  end

  #metric and resource are keys or ids
  #date 
  def self.timemachine(resource, metrics=[], options = {})
    metrics ||= []

    options[:from_datetime] = date.iso8601 unless options[:date].nil?
    options[:to_datetime] = (date + 1.day).iso8601 unless options[:date].nil?
    options[:metrics] = metrics.join(',')
    options[:resource] = resource.to_s
    http_get(:timemachine,options)
  end
  
  class << self
    alias_method :projects, :resources
    alias_method :metric_snapshots, :timemachine
    alias_method :time_machine, :timemachine
  end

end

