## インストールGem
gem 'minimum-omniauth-scaffold'
gem 'ar_to_hash'

gem 'action_args'
gem 'html5_validators'
gem 'puma'
gem 'kaminari'
gem 'rails_config'
gem 'tapp'
gem 'awesome_print'
gem 'i18n_generators'
gem 'exception_notification'
gem 'haml-rails'
gem 'ruby-duration'
gem 'everywhere'

## Markdown & Syntax Highlight
gem 'redcarpet'
gem 'coderay'

## Development
gem_group :development do
  # gem "heroku_san"
  gem 'pry-rails'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem "erb2haml"
  gem 'quiet_assets'
  gem 'colorize_unpermitted_parameters'
  gem 'rails-flog-disable-sql-format', require: 'flog'
  gem 'bullet'
end

## Development and Test
gem_group :development, :test do
  gem "sqlite3"
  gem 'rspec-rails'
end

## Production
gem_group :production do
  gem 'rails_12factor'
  gem 'pg'
  gem 'newrelic_rpm'
  gem 'bounscale'
  gem 'bugsnag'
  gem 'appsignal'
end

## Ruby Version Insert
insert_into_file "Gemfile",
  "ruby '2.1.1'\n",
  after: "source 'https://rubygems.org'\n"

## Add Strong Parameters config
insert_into_file "config/environments/development.rb",
  "\n  # Strong Parametersエラー例外発生\n  config.action_controller.action_on_unpermitted_parameters = :raise\n",
  after: "# config.action_view.raise_on_missing_translations = true\n"

## CommentOut
comment_lines 'Gemfile', "gem 'sqlite3'"

## Gem Install
run "bundle install --without production"
run "bundle update"

## Generate Command
# run "rails generate heroku_san"
run "rails generate rspec:install"
