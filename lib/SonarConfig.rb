require 'rubygems' #dont' do this
require 'yaml'
class SonarConfig
  attr_accessor :api_uri, :require_authentication, :username, :password

  def to_yaml
    Yaml::dump self
  end
  
  def http_basic_authentication
    if require_authentication
      return [username,password]
    else
      return nil
    end
  end

  def self.from_yaml(file)
    YAML::load file
  end
end
