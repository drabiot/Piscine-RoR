#!/usr/bin/env -S ruby -w

RED		= "\e[31m"
GREEN	= "\e[32m"
YELLOW	= "\e[33m"
ORANGE	= "\e[38;5;208m"
BLUE	= "\e[34m"
PURPLE	= "\e[35m"
CYAN	= "\e[36m"
BASE	= "\e[0m"

class Dup_file < StandardError
	def show_state(path)
		dir  = File.dirname(path)
		base = File.basename(path, ".*")
		ext  = File.extname(path)
		puts "#{RED}A file named #{PURPLE}#{path.chomp(".html")} #{RED}was already there: #{PURPLE}#{File.expand_path(path).chomp(path)}#{RED}:#{BASE}"
		Dir["#{dir}/#{base}*#{ext}"].each { |f| puts "\t#{CYAN}#{File.expand_path(f)}#{BASE}" }
	end

	def correct(path)
		ext = File.extname(path)
		base = path.chomp(ext)
		
		new_path = "#{base}.new#{ext}"
		loop do
			break unless File.exist?(new_path)
			new_path = "#{new_path.chomp(ext)}.new#{ext}"
		end

		File.open(new_path, 'w') { |f| yield f }

		return new_path
	end
 
	def explain(new_path)
		puts "#{YELLOW}Appended .new in order to create requested file: #{ORANGE}#{File.expand_path(new_path)}#{BASE}"
	end
end

class Body_closed < StandardError
	def show_state(path)
		puts "#{RED}In #{PURPLE}#{path.chomp(".html")}#{RED} body was closed#{BASE}"
	end

	def correct(path, string)
		lines = File.readlines(path)
		ret_line = lines.index { |l| l.strip == "</body>" } + 1
		lines.reject! { |l| l.strip == "</body>" }

		if string != "</body>"
			lines << "\t<p>#{string}</p>\n"
		end
		lines << "</body>\n"
		File.write(path, lines.join)

		return ret_line
	end

	def explain(line)
		puts " #{YELLOW}>#{ORANGE} ln :#{line} #{YELLOW}: text has been inserted and tag moved at the end of it."
	end
end

class Html
	attr_reader :page_name

	def initialize(file)
		@page_name = file

		begin
			raise Dup_file if File.exist?("#{@page_name}.html")
			File.open("#{@page_name}.html", 'w') { |f| head(f) }
		rescue Dup_file => e
			e.show_state("#{@page_name}.html")
			new_path = e.correct("#{@page_name}.html") { |f| head(f) }
			e.explain(new_path)
			@page_name = new_path.chomp(".html")
		end
	end

	def head(f)
		f.puts "<!DOCTYPE html>"
		f.puts "<html>"
		f.puts "<head>"
		f.puts "\t<title>#{@page_name}</title>"
		f.puts "</head>"
		f.puts "<body>"
	end

	def dump(string)
		raise "There is no body tag in #{@page_name}.html" unless File.read("#{@page_name}.html").include?("<body>")

		begin
			raise Body_closed if File.read("#{@page_name}.html").include?("</body>")
			File.open("#{@page_name}.html", "a") do |f|
				f.puts "\t<p>#{string}</p>"
			end
		rescue Body_closed => e
			e.show_state("#{@page_name}.html")
			line = e.correct("#{@page_name}.html", string)
			e.explain(line)
		end
	end

	def finish
		begin
			raise Body_closed if File.read("#{@page_name}.html").include?("</body>")
			File.open("#{@page_name}.html", "a") do |f|
				f.puts "</body>"
			end
		rescue Body_closed => e
			e.show_state("#{@page_name}.html")
			line = e.correct("#{@page_name}.html", "</body>")
			e.explain(line)
		end
	end
end

if $PROGRAM_NAME == __FILE__
	File.delete("test.html") if File.exist?("test.html")
	File.delete("test.new.html") if File.exist?("test.new.html")
	File.delete("test2.html") if File.exist?("test2.html")
	File.delete("test3.html") if File.exist?("test3.html")
	puts "\e[32mBasic Test for Creation\e[0m"

	a = Html.new("test")
	10.times { |x| a.dump("titi_number#{x}") }
	a.finish

	puts File.read("test.html")

	puts "\n\e[32mSame name Error\e[0m"
	b = Html.new("test")
	10.times { |x| b.dump("titi_number#{x}") }
	b.finish

	puts "\n\e[32mDump when body is closed\e[0m"
	c = Html.new("test2")
	10.times { |x| c.dump("titi_number#{x}") }
	c.finish
	10.times { |x| c.dump("titi_number#{x}") }

	puts "\n\e[32mClose the body when body already closed\e[0m"
	d = Html.new("test3")
	10.times { |x| d.dump("titi_number#{x}") }
	d.finish
	d.finish
end
