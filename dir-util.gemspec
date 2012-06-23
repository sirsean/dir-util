$:.push File.expand_path("../lib", __FILE__)
require "dir-util"

spec = Gem::Specification.new do |s|
  s.name = 'dir-util'
  s.version = DirUtil::VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = false
  s.summary = "A collection of useful utility functions for working with directories"
  s.description = "A collection of useful utility functions for working with directories"
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rcov' if RUBY_VERSION.split('.')[1].to_i == 8
  s.add_development_dependency 'simplecov' if RUBY_VERSION.split('.')[1].to_i == 9
  s.author = "Sean Schulte"
  s.email = "sirsean@gmail.com"
  s.homepage = "http://vikinghammer.com"
  s.required_ruby_version = ">= 1.8.6"
  s.files = %w(README.md Rakefile) + Dir["{lib,bin,spec,doc}/**/*"]
  s.test_files= Dir.glob('test/*_spec.rb')
  s.require_path = "lib"
end

