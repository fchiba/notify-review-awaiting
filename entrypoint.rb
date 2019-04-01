#!/usr/bin/env ruby

require 'octokit'
require 'pp'

client = Octokit::Client.new(:access_token => ENV['GITHUB_TOKEN'])

pull_requests = client.pull_requests(ENV['GITHUB_REPOSITORY'], :state => 'open')

pull_requests.each{ |pr|
#	pp pr
	if pr.created_at + (60*60*24) > Time.now && pr.requested_reviewers.empty?
		p pr.title
		p pr.html_url
		p pr.created_at + (60*60*24) > Time.now
	end
}

