# This file is used by Rack-based servers to start the application.

require 'rack-livereload'
use Rack::LiveReload

require_relative 'config/environment'
run Rails.application
