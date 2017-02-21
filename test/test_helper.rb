ENV['RAILS_ENV'] = 'test'
require 'simplecov'

SimpleCov.start do
  add_filter '/test/'
end

require 'coveralls'
Coveralls.wear!

require File.expand_path("../../config/environment", __FILE__)
require 'rails/test_help'
require 'minitest/rails'
require 'mocha/setup'
require 'capybara/rails'
require 'capybara-screenshot/minitest'
require 'shoulda/matchers'

Capybara.javascript_driver = :webkit
Capybara.app_host = "http://www.lvh.me:3200"
Capybara.server_port = 3200
Capybara.default_max_wait_time = ENV['CAPYBARA_MAX_WAIT_TIME'].try(:to_i) || 4 # default 2 seconds
Capybara::Screenshot.webkit_options = { width: 1200, height: 1536 }
Capybara::Screenshot.prune_strategy = :keep_last_run

Capybara::Webkit.configure do |config|
  config.ignore_ssl_errors
  config.block_unknown_urls
  config.allow_url('http://www.lvh.me')
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL
  include Capybara::Screenshot::MiniTestPlugin

  setup do
    use_javascript_driver
  end

  teardown do
    use_default_driver
  end

  def use_javascript_driver
    @current_driver = Capybara.current_driver
    Capybara.current_driver = Capybara.javascript_driver
  end

  def use_default_driver
    @current_driver = Capybara.current_driver
    Capybara.current_driver = Capybara.default_driver
  end
end

