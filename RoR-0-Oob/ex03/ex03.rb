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
end

if $PROGRAM_NAME == __FILE__
	html	= Elem.new('html')
	head	= Elem.new('head')
	body	= Elem.new('body')
	title	= Elem.new('title', "blah blah")
	content	= Elem.new('p', Text.new("Hello World!"))

	body.add_content(content)
	head.add_content(title)
	html.add_content([head, body])
	puts html
end
