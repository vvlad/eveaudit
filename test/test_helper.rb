# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module Support; end
Dir.glob("#{File.expand_path(__dir__)}/support/**/*.rb").each { |file| require file }

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  include Support::Dataset

  # Add more helper methods to be used by all tests here...
end
