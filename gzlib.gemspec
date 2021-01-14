# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gzlib/version'

Gem::Specification.new do |spec|
  spec.name          = 'gzlib'
  spec.version       = Gzlib::VERSION
  spec.authors       = ['ken']
  spec.email         = ['block24block@gmail.com']

  spec.summary       = 'search books on http://opac.gzlib.gov.cn/'
  spec.homepage      = 'https://github.com/turnon/gzlib'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = ['gzlib']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '> 1.9'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'

  spec.add_dependency 'nokogiri', '~> 1.6'
  spec.add_dependency 'webrick', '~> 1.7'
end
