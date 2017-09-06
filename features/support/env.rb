require 'factory_girl'
require 'database_cleaner'
require 'database_cleaner/cucumber'
require 'capybara/cucumber'

ENV['RAILS_ENV'] ||= 'fullstack'
puts Dir.pwd
root = Dir[File.dirname(File.expand_path('../../', __FILE__))].first
rails_root = File.join(root, "backend")
require File.expand_path("#{rails_root}/config/environment")



# Database Cleaner to clear out the test DB between tests
DatabaseCleaner.strategy = :truncation

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app,
    browser: :chrome,
    desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
      'chromeOptions' => {
        'prefs' => {
          'download.default_directory' => DownloadHelpers::PATH.to_s,
          'download.prompt_for_download' => false,
        }
      }
    )
  )
end

Capybara.configure do |config|
  config.app_host = 'http://localhost:4200'
  config.default_driver = (ENV['BROWSER'] || :chrome).to_sym
end

Before do
  clear_downloads
end

After do
  Capybara.reset_sessions!
  page.execute_script("window.stubbedJwt = undefined")
  visit '/'
  page.execute_script("localStorage.clear()")

  clear_downloads
end

# Shorthand FactoryGirl
include FactoryGirl::Syntax::Methods
