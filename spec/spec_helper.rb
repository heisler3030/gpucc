# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'date'
require 'rspec/rails'
require 'email_spec'
require 'capybara/rspec'
require 'webmock/rspec'
require 'rails-controller-testing'
Rails::Controller::Testing.install

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

# Use Poltergeist driver for compatibility with Travis CI, and tell it to ignore JS errors
require 'capybara/poltergeist'
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, :js_errors => false)
end
Capybara.javascript_driver = :poltergeist

# For c9 test environment
Capybara.server_port = ENV['PORT']
Capybara.server_host = ENV['IP']

# Tell FactoryBot where to find the factories
# FactoryBot.definition_file_paths = [File.expand_path('../factories', __FILE__)]

# Tell FactoryBot to load the factories
# FactoryBot.find_definitions

RSpec.configure do |config|
  
  # Deprecation Stuff
  config.expose_current_running_example_as :example
  config.infer_spec_type_from_file_location!  
  
  config.include(EmailSpec::Helpers)
  config.include(EmailSpec::Matchers)
  config.include FactoryBot::Syntax::Methods
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  #config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  #config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    FactoryBot.find_definitions
  end
  config.before(:each) do
    # Disable Webmock restrictions for feature tests.
    if example.metadata[:type] == :feature
      WebMock.allow_net_connect!
    else
      WebMock.disable_net_connect!
      DatabaseCleaner.clean_with :truncation
    end
  end
  config.after(:each) do
    DatabaseCleaner.clean
  end
  # In event of errors, open page
  config.after do
    if example.metadata[:type] == :feature and example.exception.present?
      #save_and_open_screenshot
    end
  end
end

RSpec.shared_context 'login methods' do
  
	let(:admin_login) do
		admin = create(:test_admin)
		visit new_user_session_path  
		fill_in 'user[email]', with: admin.email
		fill_in 'user[password]', with: admin.password
		click_button "Sign in"
	end

	let(:user_login) do
		user = create(:test_user)
		visit new_user_session_path  
		fill_in 'user[email]', with: user.email
		fill_in 'user[password]', with: user.password
		click_button "Sign in"
	end
	
end