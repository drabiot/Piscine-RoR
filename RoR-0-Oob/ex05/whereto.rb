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

class Page
	def initialize(elem)
		raise ArgumentError, "Expected an Elem instance, got #{elem.class}" unless elem.is_a?(Elem)
		@elem = elem
	end

	VALID_TYPES = [Html, Head, Body, Title, Meta, Img, Table, Th, Tr, Td, Ul, Ol, Li, H1, H2, P, Div, Span, Hr, Br, Text]

	def valid?
		result = validate_node(@elem)
		puts result ? "\t\tFILE IS OK" : "\t\tFILE IS INVALID"
		return result
	end

	private

	def validate_node(node)
		unless VALID_TYPES.any? { |t| node.is_a?(t) }
			return false
		end

		case node
			when Html
				puts "Currently evaluating a Html :"
				puts "- root element of type \"html\""
				puts "- Html -> Must contains a Head AND a Body after it"
				
				content = node.content
				unless content.is_a?(Array) && content.length == 2 && content[0].is_a?(Head) && content[1].is_a?(Body)
					puts "Head is INVALID"
					return false
				end
				puts "Head is OK"

				puts "Evaluating a multiple node"
				head_valid = validate_node(content[0])
				
				puts "Evaluating a multiple node"
				body_valid = validate_node(content[1])
				
				return head_valid && body_valid

			when Head
				content = node.content
				unless content.is_a?(Array) && content.length == 1 && content[0].is_a?(Title)
					return false
				end
				return validate_node(content[0])

			when Body, Div
				content = Array(node.content)
				allowed = [H1, H2, Div, Table, Ul, Ol, Img, Span, Text]
				unless content.all? { |c| allowed.any? { |t| c.is_a?(t) } }
					return false
				end
				return content.all? { |child| validate_node(child) }

			when Title, H1, H2, Li, Th, Td
				content = Array(node.content)
				unless content.length == 1 && content[0].is_a?(Text)
					return false
				end
				return validate_node(content[0])

			when P
				content = Array(node.content)
				unless content.all? { |c| c.is_a?(Text) }
					return false
				end
				return content.all? { |child| validate_node(child) }

			when Span
				content = Array(node.content)
				unless content.all? { |c| c.is_a?(Text) || c.is_a?(P) }
					return false
				end
				return content.all? { |child| validate_node(child) }

			when Ul, Ol
				content = Array(node.content)
				unless content.length >= 1 && content.all? { |c| c.is_a?(Li) }
					return false
				end
				return content.all? { |child| validate_node(child) }

			when Tr
				content = Array(node.content)
				all_th = content.all? { |c| c.is_a?(Th) }
				all_td = content.all? { |c| c.is_a?(Td) }
				unless content.length >= 1 && (all_th || all_td)
					return false
				end
				return content.all? { |child| validate_node(child) }

			when Table
				content = Array(node.content)
				unless content.all? { |c| c.is_a?(Tr) }
					return false
				end
				return content.all? { |child| validate_node(child) }

			when Img
				puts "Currently evaluating a Img :"
				src = node.opt[:src] || node.opt['src']
				unless src && src.is_a?(Text)
					return false
				end
				puts "Img content is OK"
				return true

			when Text
				puts "Currently evaluating a Text :"
				puts "-Text -> Must contains a simple string"
				
				if node.to_s.is_a?(String)
					puts "Text content is OK"
					true
				else
					puts "Text content is INVALID"
					false
				end

			when Meta, Hr, Br
				return true

			else
				return false
		end
	end
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
