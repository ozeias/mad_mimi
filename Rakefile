$:.unshift File.expand_path("../lib", __FILE__)
require 'bundler'
require 'rake'
begin
  Bundler::GemHelper.install_tasks
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rspec'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end
task :default => :spec

desc 'Open an irb session preloaded with this library'
task :console do
  sh 'irb -rubygems -I lib -r mad_mimi.rb'
end