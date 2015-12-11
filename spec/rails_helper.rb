# This file is copied to spec/ when you run "rails generate rspec:install"
ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require "spec_helper"
require "rspec/rails"
require "capybara/rspec"
require "capybara/rails"
require "capybara/poltergeist"
require "capybara-screenshot"
require "capybara-screenshot/rspec"
require "simplecov"
SimpleCov.start "rails"

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app,
                                      js_errors: false,
                                      phantomjs_options: ["--proxy-type=none"],
                                      timeout: 180,
                                      :phantomjs_logger => File.open("#{Rails.root}/log/test_phantomjs.log", "a"),
                                      extensions: [])
  end

  Capybara.javascript_driver = :poltergeist
  Capybara.default_selector = :css
  Capybara.default_wait_time = 5

  Capybara::Screenshot.register_filename_prefix_formatter(:rspec) do |example|
    'screenshot-#{example.description.gsub(" ", "-").delete(",").gsub("/", "-").delete(""")}'
  end
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
