# Load the Rails application.
require_relative 'application'

# Validate ENV variables are properly set
ok = true
unless ENV['APPNAME']         then puts "Missing APPNAME environment variable";  ok = false end
unless ENV['SECRET_TOKEN']    then puts "Missing SECRET_TOKEN environment variable";  ok = false end
unless ENV['ADMIN_EMAIL']     then puts "Missing ADMIN_EMAIL environment variable";  ok = false end
unless ENV['ADMIN_NAME']      then puts "Missing ADMIN_NAME environment variable";  ok = false end
unless ENV['ADMIN_PASSWORD']  then puts "Missing ADMIN_PASSWORD environment variable";  ok = false end
unless ENV['GMAIL_USERNAME']  then puts "Missing GMAIL_USERNAME environment variable";  ok = false end
unless ENV['GMAIL_PASSWORD']  then puts "Missing GMAIL_PASSWORD environment variable";  ok = false end
if !ok then raise "Missing ENV variables" end

# Initialize the Rails application.
Rails.application.initialize!