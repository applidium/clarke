# frozen_string_literal: true

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))
require 'clarke/version'

Gem::Specification.new do |s|
  s.name        = 'clarke'
  s.version     = Clarke::VERSION
  s.summary     = 'Clarke is a DSL for easily building converstional bots in Ruby.'
  s.description = 'Clarke is a DSL library designed to easily build conversational bots in Ruby. It abstracts the UI platform used from the core of the application. Using the UI libraries, you can use your Clarke application on multiple platform with the exact same code.'

  s.license     = 'MIT'

  s.authors     = ['Applidium', 'Cyril Canete']
  s.email       = 'contact+clarke@applidium.com'
  s.homepage    = 'https://github.com/applidium/clarke'

  s.files       = Dir['CHANGELOG.md', 'CONTRIBUTORS', 'README.md', 'LICENSE', 'lib/**/*']
  s.require_paths = ['lib']
end
