FROM ruby:2.6

LABEL "name"="notify-review-awaiting"
LABEL "maintainer"="Fumiya Chiba <fumiya.chiba@nifty.com>"
LABEL "version"="1.0.0"

LABEL "com.github.actions.name"="Notify-review-awaiting"
LABEL "com.github.actions.description"="Notify pull-requests which no reviewers are assigned to"
LABEL "com.github.actions.icon"="terminal"
LABEL "com.github.actions.color"="gray-dark"

COPY Gemfile Gemfile.lock /
COPY entrypoint.rb /entrypoint.rb
RUN bundle install

ENTRYPOINT ["bundle", "exec", "/entrypoint.rb"]

