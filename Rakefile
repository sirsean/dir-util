require 'rubygems'
require 'rspec/core/rake_task'
require "#{File.dirname(__FILE__)}/lib/dir-util"

task :default => :spec
RSpec::Core::RakeTask.new(:spec)

desc 'Run all rspec tests with rcov (1.8 only)'
RSpec::Core::RakeTask.new(:rcov) do |t|
    t.rcov_opts =  %q[--exclude "spec,gems"]
    t.rcov = true
end

namespace :gem do
    task :build do
        puts `yard`
        puts `gem build dir-util.gemspec`
    end

    task :install do
        puts `gem install dir-util-#{DirUtil::VERSION}.gem`
    end

    task :uninstall do
        puts `gem uninstall dir-util`
    end
end

desc 'Build yard documentation'
task :yard do
    puts `yard`
    `open doc/index.html`
end
