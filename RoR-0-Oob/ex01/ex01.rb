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
	a = Html.new("test")
	10.times { |x| a.dump("titi_number#{x}") }
	a.finish

	puts File.read("test.html")
end
