# notify-review-awaiting

You will be notified of PRs that are left wihtout reviewers.

Use with Github Actions.

## Environmental variables

- GITHUB_REPOSITORY

  Github repository name. Github Actions set automatically this variable.
  
  ex) `fchiba/notify-review-awaiting`
  
- GITHUB_TOKEN

  Access token for github. You can set with "Secrets" on the visual editor.
  
- WAITING_SECONDS

  You will be notified after this time from created.
  
  ex) `3600`
  
- SLACK_API_TOKEN

  Slack API token. See https://api.slack.com/
  
  You should set with "Secrets" on the visual editor.
  
  ex) `xoxp-**********-************-************-********************************`
  
- SLACK_CHANNEL

  Messages are posted to this slack channel
  
  ex) `#general`
