#!/usr/bin/env -S ruby -w

class Text
	def initialize(string)
		@string = string
	end

	def to_s
		@string
	end
end

class Elem
	attr_reader :tag, :content, :opt, :tag_type

	def initialize(tag, content = [], tag_type = 'double', opt = {})
		@tag = tag
		@content = content
		@opt = opt
		@tag_type = tag_type
	end

	def add_content(*args)
		@content = [] unless @content.is_a?(Array)
		args.flatten.each { |elem| @content << elem }
	end

	def to_s
		attrs = @opt.map { |k, v| " #{k}='#{v}'" }.join

		if @tag_type == 'simple'
			"<#{@tag}#{attrs} />"
		else
			if @content.is_a?(Array)
				inner = @content.map(&:to_s).join("\n")
				inner.empty? ? "<#{@tag}#{attrs}>\n</#{@tag}>" : "<#{@tag}#{attrs}>\n#{inner}\n</#{@tag}>"
			else
				"<#{@tag}#{attrs}>#{@content}</#{@tag}>"
			end
		end
	end

	def self.define(name, type = :double)
		tag_type = type == :simple ? 'simple' : 'double'

		klass = Class.new(self) do
			define_method(:initialize) do |content = [], opt = {}|
				super(name.to_s, content, tag_type, opt)
			end
		end
		Object.const_set(name, klass)
	end
end

%i[Html Head Body Title Table Th Tr Td Ul Ol Li H1 H2 P Div Span].each do |name|
	Elem.define(name)
end

%i[Meta Img Hr Br].each do |name|
	Elem.define(name, :simple)
end

if $PROGRAM_NAME == __FILE__
	toto = Html.new([Head.new([Title.new(Text.new("Hello ground!"))]),
	Body.new([H1.new(Text.new("Oh no, not again!")), Img.new([],
	{'src': Text.new('http://i.imgur.com/pfp3T.jpg')}) ]) ])
	test = Page.new(toto)
	test.valid?
	tata = Html.new([Head.new([Title.new(Text.new("Hello ground!"))]),
	Body.new([H1.new(Text.new("Oh no, not again!")), Img.new([],
	{'src': Text.new('http://i.imgur.com/pfp3T.jpg')}) ]) ])
	test2 = Page.new(tata)
	test2.valid?
end
