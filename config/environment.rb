# Load the Rails application.
require_relative "application"
require "carrierwave"
require "carrierwave/orm/activerecord"

# Initialize the Rails application.
Rails.application.initialize!

require_relative 'path/to/users_controller'
