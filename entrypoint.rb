#!/usr/bin/env ruby

require 'octokit'
require 'pp'
require 'slack-ruby-client'

GITHUB_TOKEN = ENV['GITHUB_TOKEN']
GITHUB_REPOSITORY = ENV['GITHUB_REPOSITORY']
WAITING_SECONDS = ENV['WAITING_SECONDS'].to_i
SLACK_API_TOKEN = ENV['SLACK_API_TOKEN']
SLACK_CHANNEL = ENV['SLACK_CHANNEL']

github = Octokit::Client.new(:access_token => GITHUB_TOKEN)
Slack.configure do |config|
  config.token = SLACK_API_TOKEN
end
slack = Slack::Web::Client.new
slack.auth_test

pull_requests = github.pull_requests(GITHUB_REPOSITORY, :state => 'open')

waitings = pull_requests.find_all{ |pr| pr.created_at + WAITING_SECONDS < Time.now && pr.requested_reviewers.empty? && github.pull_request_reviews(GITHUB_REPOSITORY, pr.number).empty?}

exit if waitings.empty?

message = "Awaiting reviews:\n"
waitings_per_milestone = waitings.group_by { |pr| pr.milestone ? pr.milestone.title : "No milestone" }
waitings_per_milestone.keys.sort.each { |key|
	message += ":triangular_flag_on_post: #{key}\n"
	waitings_per_milestone[key].each { |pr|
		message += " - *#{pr.title}* <#{pr.html_url}>\n"
	}
}
slack.chat_postMessage(channel: SLACK_CHANNEL, text: message)
