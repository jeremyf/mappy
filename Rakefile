require "bundler/gem_tasks"
require 'yard'
require 'rspec/core/rake_task'

YARD::Rake::YardocTask.new do |t|
  t.files = ['lib/**/*.rb', 'lib/mappy.rb', '-', 'README.md', 'LICENSE']
  t.options = ['--no-private']
end

RSpec::Core::RakeTask.new

namespace :spec do
  desc "Run rspec and generate code coverage"
  RSpec::Core::RakeTask.new(:coverage)
end

task :default => ['spec:coverage', 'yard']
