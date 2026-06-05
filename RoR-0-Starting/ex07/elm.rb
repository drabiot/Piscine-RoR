def create_head(f)
	f.puts "<!DOCTYPE html>"
	f.puts "<html lang=\"en\">"
	f.puts "<head>"
	f.puts "\t<meta charset=\"UTF-8\">"
	f.puts "\t<title>Periodic Table</title>"
	f.puts "\t<style>"
	f.puts "\t\ttable { border-collapse: collapse; width: 100%; table-layout: fixed; }"
	f.puts "\t\ttd { border: 1px solid black; padding: 4px; vertical-align: top; overflow: hidden; font-size: 11px; }"
	f.puts "\t\th4 { margin: 0 0 5px 0; }"
	f.puts "\t\tul { margin: 0; padding-left: 15px; }"
	f.puts "\t</style>"
	f.puts "</head>"
end

def get_period(number)
	case number
	when 1..2		then 1
	when 3..10		then 2
	when 11..18 	then 3
	when 19..36 	then 4
	when 37..54 	then 5
	when 55..86		then 6
	when 87..118	then 7
	end
end

def parse_table
	file = "periodic_table.txt"
	unless File.exist?(file)
		puts "#{file} not found"
		return []
	end

	elements = []
	File.readlines(file).each do |line|
		next if line.strip.empty?

		name		= line.split("=").first.strip
		position 	= line.match(/position:(\d+)/)[1].to_i
		number		= line.match(/number:(\d+)/)[1].to_i
		small		= line.match(/small:\s*(\S+)/)[1].delete(",")
		molar		= line.match(/molar:([\d.]+)/)[1].to_f
		electrons	= line.match(/electron:([\d ]+)/)[1].strip

		elements << { name: name, position: position, number: number, small: small, molar: molar, electrons: electrons }
	end

	elements
end

def cell(f, el)
	f.puts "\t\t\t<td>"
	f.puts "\t\t\t\t<h4>#{el[:name]}</h4>"
	f.puts "\t\t\t\t<ul>"
	f.puts "\t\t\t\t\t<li>No #{el[:number]}</li>"
	f.puts "\t\t\t\t\t<li>#{el[:small]}</li>"
	f.puts "\t\t\t\t\t<li>#{el[:molar]}</li>"
	f.puts "\t\t\t\t\t<li>#{el[:electrons]} electron</li>"
	f.puts "\t\t\t\t</ul>"
	f.puts "\t\t\t</td>"
end

def empty_cell(f)
	f.puts "\t\t\t<td style=\"border: 0px solid white;\"></td>"
end

def create_body(f, elements)
	rows = {}
	elements.each do |el|
		period = get_period(el[:number])
		rows[period] ||= {}
		rows[period][el[:position]] = el
	end

	f.puts "<body>"
	f.puts "\t<h1 style=\"text-align:center;\"><u>Periodic Table</u></h1>"
	f.puts "\t<table>"

	rows.keys.sort.each do |period|
		f.puts "\t\t<tr>"
		(0..17).each do |col|
			if rows[period][col]
				cell(f, rows[period][col])
			else
				empty_cell(f)
			end
		end
		f.puts "\t\t</tr>"
	end

	f.puts "\t</table>"
	f.puts "</body>"
	f.puts "</html>"
end

def main
	file = File.join(File.dirname(__FILE__), 'periodic_table.html')
	elements = parse_table

	File.open(file, 'w') do |f|
		create_head(f)
		create_body(f, elements)
	end
end

main