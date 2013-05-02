require 'rubygems'
require 'bundler/setup'
require "bundler/gem_tasks"

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end
namespace :spec do
  desc "Create rspec coverage"
  task :coverage do
    ENV['COVERAGE'] = 'true'
    Rake::Task["spec"].execute
  end
  
  desc "boot console with spec helpers"
  task :console do
    require File.expand_path('../spec/spec_helper.rb', __FILE__)
    require 'irb'
    ARGV.clear
    IRB.start
  end
end
