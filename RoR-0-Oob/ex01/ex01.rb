#!/usr/bin/env -S ruby -w

class Html
	def initialize(file)
		@page_name = "#{file}.html"
		raise "A file named #{@page_name} already exists" if File.exist?(@page_name)

		File.open(@page_name, 'w') do |f|
			head(f)
		end
	end

	def head(f)
		f.puts "<!DOCTYPE html>"
		f.puts "<html lang=\"en\">"
		f.puts "<head>"
		f.puts "\t<meta charset=\"UTF-8\">"
		f.puts "\t<title>#{@page_name}</title>"
		f.puts "</head>"
		f.puts "<body>"
	end

	def dump(string)
		raise "There is no body tag in  #{@page_name}" unless File.read(@page_name).include?("<body>")
		raise "The body has already been closed in #{@page_name}" if File.read(@page_name).include?("</body>")

		File.open(@page_name, "a") do |f|
			f.puts "\t<p>#{string}</p>"
		end
	end

	def finish
		raise "#{@page_name} has already been closed" if File.read(@page_name).include?("</body>")
		
		File.open(@page_name, "a") do |f|
			f.puts "</body>"
		end
	end
end

if $PROGRAM_NAME == __FILE__
	File.delete("test.html") if File.exist?("test.html")
	puts "\e[32mBasic Test for Creation\e[0m"

	a = Html.new("test")
	10.times { |x| a.dump("titi_number#{x}") }
	a.finish

	puts File.read("test.html")
	puts "\n"

	begin
		puts "\e[32mSame name Error\e[0m"
		b = Html.new("test")
		10.times { |x| b.dump("titi_number#{x}") }
		b.finish
	rescue RuntimeError => e
		puts "\e[31mRaised Error : #{e.message}\e[0m\n\n"
	end

	begin
		puts "\e[32mDump when body is closed\e[0m"
		c = Html.new("test2")
		10.times { |x| c.dump("titi_number#{x}") }
		c.finish
		10.times { |x| c.dump("titi_number#{x}") }
	rescue RuntimeError => e
		puts "\e[31mRaised Error : #{e.message}\e[0m\n\n"
	ensure
		File.delete("test2.html") if File.exist?("test2.html")
	end

	begin
		puts "\e[32mClose the body when body already closed\e[0m"
		d = Html.new("test3")
		10.times { |x| d.dump("titi_number#{x}") }
		d.finish
		d.finish
	rescue RuntimeError => e
		puts "\e[31mRaised Error : #{e.message}\e[0m\n\n"
	ensure
		File.delete("test3.html") if File.exist?("test3.html")
	end
end
