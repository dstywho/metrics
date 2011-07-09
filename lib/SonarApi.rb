require 'rubygems'
require 'addressable/uri'
require 'open-uri'

class SonarApi
  URI = Addressable::URI.parse "http://nemo.sonarsource.org/api/"
  
  def self.url(path, options={:format => 'json'})
    options = {:format =>'json'} if options.nil?
    url = URI.join path.to_s
    url.query_values = options
    url.to_s
  end

  def self.metrics(options=nil)
    open(url(:metrics, options)).readlines[0]
  end

  def self.resources(options=nil)
    open(url(:resources, options)).readlines[0]
  end

end

