# Reference: [rails-app-template/rails-app-template.rb at master · labocho/rails-app-template](https://github.com/labocho/rails-app-template/blob/master/rails-app-template.rb)

template_path = "#{File.dirname(__FILE__)}/templates"

# ---------- Install Gem ---------- #
## Utilities
gem 'minimum-omniauth-scaffold'
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
gem 'opal-rails'

## Markdown & Syntax Highlight
gem 'redcarpet'
gem 'coderay'

## Development
gem_group :development do
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
end

# ---------- Assets ---------- #
## Replace application.js
remove_file "application.js"
content =  "//= require opal\n"
content += "//= require opal_ujs\n"
content += "//= require turbolinks\n"
content += "//= require_tree .\n"
create_file "app/assets/javascripts/application.js.rb", content.force_encoding('ASCII-8BIT')

# ---------- Config ---------- #
## application.rb setting
content = "    config.time_zone = 'Tokyo'\n"
insert_into_file "config/application.rb", content.force_encoding('ASCII-8BIT'), after: "# config.time_zone = 'Central Time (US & Canada)'\n"
insert_into_file "config/application.rb", "    config.i18n.default_locale     = :ja\n    I18n.enforce_available_locales = false\n", after: "# config.i18n.default_locale = :de\n"
content =  "    # For Tapp\n"
content += "    Tapp.config.default_printer = :awesome_print\n"
content += "    # For Opal - These are the available options with their default value:\n"
content += "    config.opal.method_missing      = true\n"
content += "    config.opal.optimized_operators = true\n"
content += "    config.opal.arity_check         = false\n"
content += "    config.opal.const_missing       = true\n"
content += "\n"
insert_into_file "config/application.rb", content.force_encoding('ASCII-8BIT'), after: "class Application < Rails::Application\n"

## production.rb setting
insert_into_file "config/environments/production.rb", "  config.force_ssl = true\n", after: "# config.force_ssl = true\n"  # 強制SSL設定

## development.rb setting
gsub_file "config/environments/development.rb", /(config.assets.debug = true)+/, "# config.assets.debug = true"                  # コメントアウト追加
insert_into_file "config/environments/development.rb", "  config.assets.debug = false\n", after: "config.assets.debug = true\n"  # false設定追加

## Add Strong Parameters config
insert_into_file "config/environments/development.rb",
  "\n  # Strong Parametersエラー例外発生\n  config.action_controller.action_on_unpermitted_parameters = :raise\n",
  after: "# config.action_view.raise_on_missing_translations = true\n"

# ---------- Gemfile ---------- #
## Ruby Version Insert
insert_into_file "Gemfile",
  "ruby '2.1.5'\n",
  after: "source 'https://rubygems.org'\n"

## Comment Out
comment_lines 'Gemfile', "gem 'sqlite3'"

## Gem Install
run "bundle install --without production"
run "bundle update"

# ---------- RSpec ---------- #
## Generate Command
run "rails generate rspec:install"

# ---------- Git ---------- #
git :init
