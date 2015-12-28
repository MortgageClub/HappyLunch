source 'https://rubygems.org'

ruby '2.2.2'

gem 'rails', '4.2.3'

gem 'rails-api'

gem 'spring', :group => :development

gem 'pg'

gem 'jbuilder'

gem 'poltergeist'

gem 'puma'

gem 'dotenv-rails'

gem 'faraday'
gem 'faraday_middleware'
gem 'faraday_middleware-parse_oj', '~> 0.3.0'
gem 'nokogiri'

group :development, :test do
  gem 'awesome_print'
  gem 'byebug'
  gem 'rubocop'
end

group :production do
  # Makes running your Rails app easier. Based on the ideas behind 12factor.net
  gem 'rails_12factor'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', platforms: :ruby
end
