# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../../../spec/dummy/config/environment.rb",  __FILE__)
ENV["RAILS_ROOT"] = File.expand_path("../../../spec/dummy", __FILE__)
require 'cucumber/rails'
require 'factory_girl'

ActionController::Base.allow_rescue = false
DatabaseCleaner.strategy = :truncation
Rails.backtrace_cleaner.remove_silencers!
