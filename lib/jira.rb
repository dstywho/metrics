require 'rubygems'
require 'jira4r'

jiraBaseUrl      = "https://www.calgbapps.org:443/jira"
jiraUsername     = "34653"
jiraPassword     = "rome!123d"
 
jira = Jira4R::JiraTool.new(2, jiraBaseUrl)
jira.login(jiraUsername, jiraPassword)

jira.getProjects().each { |project|
  puts project.key
}
