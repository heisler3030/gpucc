require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Gpucc
  class Application < Rails::Application
    
    # don't generate RSpec tests for views and helpers
    config.generators do |g|
      
      g.test_framework :rspec, fixture: true
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
      
      
      g.view_specs false
      g.helper_specs false
    end    
    
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)
    config.autoload_paths += %W(#{config.root}/lib)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.encoding = "utf-8"
    #config.active_record.raise_in_transactional_callbacks = true

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password, :password_confirmation]

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.0

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    # config.active_record.schema_format = :sql

    # Enforce whitelist mode for mass assignment.
    # This will create an empty whitelist of attributes available for mass-assignment for all models
    # in your app. As such, your models will need to explicitly whitelist or blacklist accessible
    # parameters by using an attr_accessible or attr_protected declaration.
    #config.active_record.whitelist_attributes = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'
    
# HAMISH ADDS

    # As requested by Heroku
    config.assets.initialize_on_precompile = false

    # Enable GZip
    #config.middleware.use Rack::Deflater  # Dynamic Content
    #config.middleware.insert_before ActionDispatch::Static, Rack::Deflater # Static Content

    # For logging
    #config.logger = Logger.new(STDOUT)
    config.lograge.enabled = true
    
    # Precompile array... surely there is a better way
    config.assets.precompile += ['application.css', 'gpucc.css', 'home.js']

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
