$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'mappy'
require 'simplecov'
require 'rspec/its'

SimpleCov.start
SimpleCov.command_name "spec"
