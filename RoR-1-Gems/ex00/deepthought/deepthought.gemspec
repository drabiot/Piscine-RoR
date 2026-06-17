Gem::Specification.new do |s|
	s.name			= 'deepthought'
	s.version		= '0.0.1'
	s.platform		= Gem::Platform::RUBY
	s.summary		= 'First Gem'
	s.description	= "Use the deepthought to respond to our questions"
	s.authors		= ['tchartie']
	s.email			= ['tchartie@student.42angouleme.fr']
	s.license		= 'MIT'
	s.files			= Dir.glob("{lib,test}/**/*")
	s.require_path	= 'lib'

	s.add_development_dependency 'minitest'
	s.add_runtime_dependency 'colorize'
end