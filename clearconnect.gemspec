# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "clearconnect/version"

Gem::Specification.new do |s|
  s.name = 'clearconnect'
  s.version = ClearConnect::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ["Christopher Hunt"]
  s.email = 'chrahunt@gmail.com'
  s.homepage = ''
  s.summary = 'ClearConnect API Interface for Ruby'
  s.description = ''

  s.rubyforge_project = "clearconnect"
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'httparty', '~> 0.10'
  s.add_runtime_dependency 'savon', '~> 2.1.0'
  s.add_runtime_dependency 'xml-simple', '~> 1.1.2'
end