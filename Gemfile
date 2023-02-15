source 'https://rubygems.org'
ruby '2.5.8'
gem 'rails', '~> 4.2'
gem 'protected_attributes'  # For Rails 4 migration
gem 'sass'
gem 'bootstrap-sass'
gem 'sass-rails'
gem 'coffee-rails'
gem 'uglifier', '>= 1.0.3'
gem 'jquery-rails'
gem 'dynamic_form'
gem 'cancan'
# gem 'devise', '~> 3.4.1'
gem 'devise', git: 'https://github.com/plataformatec/devise' , branch: '3-stable'
gem 'devise_invitable', '~> 1.4.2'
gem 'json'
gem 'figaro'
gem 'rolify'
gem 'simple_form'
gem 'validates_timeliness', '~> 3.0'
gem 'pg', '~> 0.15'
gem 'font-awesome-rails'
gem 'summernote-rails', '~> 0.6.2.1'
gem 'lograge'

group :development do
  gem 'webrick', '~> 1.3.1'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'quiet_assets'
  gem 'rails_layout'
end

group :development, :test do
  gem 'factory_bot'
  gem 'rspec-rails'
  gem 'pry'
end

group :test do
  gem 'capybara', '~> 2.4'
  gem 'webmock'
  gem 'poltergeist'
  gem 'selenium-webdriver'
  gem 'database_cleaner' #, '1.0.1'
  gem 'email_spec'
  gem 'launchy'
  gem 'timecop'
  gem 'nokogiri'
end

group :production do
  gem 'rails_12factor'
end