#!/usr/bin/env -S ruby -w

Gem::Specification.new do |s|
	s.name			= 'ft_wikipedia'
	s.version		= '0.0.1'
	s.platform		= Gem::Platform::RUBY
	s.summary		= 'Search for Philosophy url'
	s.description	= "Take a wikipedia link and search the Philosophy link within fisrt page link"
	s.authors		= ['tchartie']
	s.email			= ['tchartie@student.42angouleme.fr']
	s.license		= 'MIT'
	s.files			= Dir.glob("{lib,test}/**/*")
	s.require_path	= 'lib'

	s.add_development_dependency 'minitest'
	s.add_development_dependency 'rake'
	s.add_runtime_dependency 'nokogiri'
end