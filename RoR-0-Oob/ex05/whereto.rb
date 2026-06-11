#!/usr/bin/env -S ruby -w

RED		= "\e[31m"
GREEN	= "\e[32m"
YELLOW	= "\e[33m"
ORANGE	= "\e[38;5;208m"
BLUE	= "\e[34m"
PURPLE	= "\e[35m"
CYAN	= "\e[36m"
BASE	= "\e[0m"

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
		puts result ? "\t\t#{GREEN}FILE IS OK#{BASE}" : "\t\t#{RED}FILE IS INVALID#{BASE}"
		return result
	end

	private

	def validate_node(node)
		unless VALID_TYPES.any? { |t| node.is_a?(t) }
			return false
		end

		case node
			when Html
				puts "#{CYAN}Currently evaluating a Html :#{BASE}"
				puts "#{BLUE}- root element of type \"html\"#{BASE}"
				puts "#{BLUE}- Html -> Must contains a Head AND a Body after it#{BASE}"
				
				content = node.content
				unless content.is_a?(Array) && content.length == 2 && content[0].is_a?(Head) && content[1].is_a?(Body)
					puts "#{RED}Head is INVALID#{BASE}"
					return false
				end
				puts "#{GREEN}Head is OK#{BASE}"

				puts "#{PURPLE}Evaluating a multiple node#{BASE}"
				head_valid = validate_node(content[0])
				
				puts "#{PURPLE}Evaluating a multiple node#{BASE}"
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
				puts "#{CYAN}Currently evaluating a Img :#{BASE}"
				src = node.opt[:src] || node.opt['src']
				unless src && src.is_a?(Text)
					puts "#{RED}Img content is INVALID#{BASE}"
					return false
				end
				puts "#{GREEN}Img content is OK#{BASE}"
				return true

			when Text
				puts "#{CYAN}Currently evaluating a Text :#{BASE}"
				puts "#{BLUE}-Text -> Must contains a simple string#{BASE}"
				
				if node.to_s.is_a?(String)
					puts "#{GREEN}Text content is OK#{BASE}"
					true
				else
					puts "#{RED}Text content is INVALID#{BASE}"
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
	puts "\n#{YELLOW}=== BASE TESTER ===#{BASE}"

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

	puts "\n#{YELLOW}=== ERROR TESTER ===#{BASE}"

    puts "\n[Error 1] Html without Head :"
    err1 = Html.new([
        Body.new([H1.new(Text.new("No Head"))])
    ])
    Page.new(err1).valid?

    puts "\n[Error 2] Title with P and not a Text :"
    err2 = Html.new([
        Head.new([Title.new([P.new(Text.new("Invalid"))])]),
        Body.new([H1.new(Text.new("Hello"))])
    ])
    Page.new(err2).valid?

    puts "\n[Error 3] Img without src :"
    err3 = Html.new([
        Head.new([Title.new(Text.new("Test Img"))]),
        Body.new([Img.new([], {'alt': Text.new('No src')})])
    ])
    Page.new(err3).valid?

    puts "\n[Error 4] Tr with Th & Td :"
    err4 = Html.new([
        Head.new([Title.new(Text.new("Test Table"))]),
        Body.new([
            Table.new([
                Tr.new([Th.new(Text.new("Header")), Td.new(Text.new("Data"))])
            ])
        ])
    ])
    Page.new(err4).valid?

    puts "\n[Error 5] P with a Span :"
    err5 = Html.new([
        Head.new([Title.new(Text.new("Test P"))]),
        Body.new([
            P.new([Span.new(Text.new("Invalid"))])
        ])
    ])
    Page.new(err5).valid?

    puts "\n[Error 6] Ul with no Li :"
    err6 = Html.new([
        Head.new([Title.new(Text.new("Blank Ul"))]),
        Body.new([
            Ul.new([])
        ])
    ])
    Page.new(err6).valid?
	end
