class Html
	def initialize(file)
		@page_name = "#{file}.html"

		content = File.join(File.dirname(__FILE__), @page_name)
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
		File.open(@page_name, "a") do |f|
			f.puts "\t<p>#{string}</p>"
		end
	end

	def finish
		File.open(@page_name, "a") do |f|
			f.puts "</body>"
		end
	end
end
