require 'rubygems'
require 'addressable/uri'
require 'open-uri'

class SonarApi
  URI = Addressable::URI.parse "http://nemo.sonarsource.org/api/"
  

  def self.url(path, options={:format => 'json'})
    options ||= {:format => 'json' }
    options[:format] = 'json' if options[:format].nil?
    url = URI.join path.to_s
    url.query_values = options
    url.to_s
  end

  def self.metrics(options={})
    open(url(:metrics, options)).readlines[0]
  end

  def self.resources(options={})
    open(url(:resources, options)).readlines[0]
  end

  #metric and resource are keys or ids
  #date 
  def self.timemachine(resource, metrics, date=nil, options = {})
    metrics ||= []

    options[:from_datetime] = date.iso8601 unless date.nil?
    options[:to_datetime] = (date + 1.day).iso8601 unless date.nil?
    options[:metrics] = metrics.join(',')
    options[:resource] = resource.to_s
    puts url(:timemachine, options)
    open(url(:timemachine, options)).readlines[0]
  end
  
  class << self
    alias_method :projects, :resources
    alias_method :metric_snapshots, :timemachine
    alias_method :time_machine, :timemachine
  end

end

