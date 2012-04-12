require 'rubygems'
require 'bundler/setup'

require 'pivotal-tracker'

require './config'

PivotalTracker::Client.token = API_KEY
project = PivotalTracker::Project.find(PROJECT_ID)

Dir.chdir(GIT_DIR)
`git branch -r --no-merged`.each_line do |raw_branch|
  branch = raw_branch.gsub("origin/", "").chomp
  puts "Branch: #{branch}"
  project.stories.all(:label => branch, :includedone => true).each do |story|
    puts "  Story: #{story.name} - #{story.current_state.upcase}"
    puts "    Requested by: #{story.requested_by}"
    puts "    Owned by: #{story.owned_by}"
    puts "    URL: #{story.url}"
    puts ""
  end
  puts ""
end
