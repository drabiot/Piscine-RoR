#!/usr/bin/env -S ruby -w

class Html
	def initialize(file)
		@page_name = file

		File.open("#{@page_name}.html", 'w') do |f|
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
		File.open("#{@page_name}.html", "a") do |f|
			f.puts "\t<p>#{string}</p>"
		end
	end

	def finish
		File.open("#{@page_name}.html", "a") do |f|
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
