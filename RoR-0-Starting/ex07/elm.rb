def create_style(f)
	f.puts "* {box-sizing: border-box;}"
	f.puts "body {font-family: 'Segoe UI', Arial, sans-serif; background: #f4f6f9; color: #1a1a2e; margin: 0; padding: 0;}"
	f.puts "h1 {font-size: 2rem; font-weight: 700; letter-spacing: 0.05em; color: #1a1a2e; margin-bottom: 4px; text-decoration: none;}"
	f.puts "h1 u {text-decoration: underline; text-underline-offset: 4px;}"
	f.puts "h2 {font-size: 1rem; font-weight: 400; color: #555; margin: 0 0 2px;}"
	f.puts "h3 {font-size: 0.85rem; font-weight: 400; color: #888; margin: 0 0 20px; letter-spacing: 0.06em; text-transform: uppercase;}"
	f.puts "table {border-collapse: separate; border-spacing: 3px; width: 100%; table-layout: fixed;}"
	f.puts "td {border: none; padding: 6px 7px; vertical-align: top; overflow: hidden; font-size: 10px; background: #ffffff; border-radius: 6px; box-shadow: 0 1px 3px rgba(0,0,0,0.07); transition: transform 0.15s ease, box-shadow 0.15s ease; line-height: 1.4;}"
	f.puts "td:not([style*='border: 0px']):hover {transform: translateY(-2px) scale(1.04); box-shadow: 0 6px 16px rgba(0,0,0,0.15); z-index: 10; position: relative;}"
	f.puts "td[style*='border: 0px'] {background: transparent; box-shadow: none; padding: 0;}"
	f.puts "td h4 {margin: 0 0 4px 0; font-size: 11px; font-weight: 600; color: #1a1a2e; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;}"
	f.puts "td ul {margin: 0; padding: 0; list-style: none;}"
	f.puts "td ul li {color: #444; line-height: 1.5;}"
	f.puts "td ul li:nth-child(1) {font-size: 9px; color: #999; font-weight: 500;}"
	f.puts "td ul li:nth-child(2) {font-size: 15px; font-weight: 700; color: #2a5caa; letter-spacing: 0.02em;}"
	f.puts "td ul li:nth-child(3) {font-size: 9px; color: #666;}"
	f.puts "td ul li:nth-child(4) {font-size: 8.5px; color: #aaa; margin-top: 1px;}"
	f.puts "tr td:nth-child(1):not([style*='border: 0px']) {border-top: 3px solid #e07b39;}"
	f.puts "tr td:nth-child(1):not([style*='border: 0px']) li:nth-child(2) {color: #b85e1f;}"
	f.puts "tr td:nth-child(2):not([style*='border: 0px']) {border-top: 3px solid #d4a017;}"
	f.puts "tr td:nth-child(2):not([style*='border: 0px']) li:nth-child(2) {color: #a07c0a;}"
	f.puts "tr td:nth-child(18):not([style*='border: 0px']) {border-top: 3px solid #8b5cf6; background: #faf8ff;}"
	f.puts "tr td:nth-child(18):not([style*='border: 0px']) li:nth-child(2) {color: #6d3fc8;}"
	f.puts "tr td:nth-child(13):not([style*='border: 0px']), tr td:nth-child(14):not([style*='border: 0px']), tr td:nth-child(15):not([style*='border: 0px']), tr td:nth-child(16):not([style*='border: 0px']), tr td:nth-child(17):not([style*='border: 0px']) {border-top: 3px solid #2a9d8f;}"
	f.puts "tr td:nth-child(13):not([style*='border: 0px']) li:nth-child(2), tr td:nth-child(14):not([style*='border: 0px']) li:nth-child(2), tr td:nth-child(15):not([style*='border: 0px']) li:nth-child(2), tr td:nth-child(16):not([style*='border: 0px']) li:nth-child(2), tr td:nth-child(17):not([style*='border: 0px']) li:nth-child(2) {color: #1a6b61;}"
	f.puts "tr td:nth-child(3):not([style*='border: 0px']), tr td:nth-child(4):not([style*='border: 0px']), tr td:nth-child(5):not([style*='border: 0px']), tr td:nth-child(6):not([style*='border: 0px']), tr td:nth-child(7):not([style*='border: 0px']), tr td:nth-child(8):not([style*='border: 0px']), tr td:nth-child(9):not([style*='border: 0px']), tr td:nth-child(10):not([style*='border: 0px']), tr td:nth-child(11):not([style*='border: 0px']), tr td:nth-child(12):not([style*='border: 0px']) {border-top: 3px solid #3a7bd5; background: #f8fbff;}"
	f.puts "tr td:nth-child(3):not([style*='border: 0px']) li:nth-child(2), tr td:nth-child(4):not([style*='border: 0px']) li:nth-child(2), tr td:nth-child(5):not([style*='border: 0px']) li:nth-child(2), tr td:nth-child(6):not([style*='border: 0px']) li:nth-child(2), tr td:nth-child(7):not([style*='border: 0px']) li:nth-child(2), tr td:nth-child(8):not([style*='border: 0px']) li:nth-child(2), tr td:nth-child(9):not([style*='border: 0px']) li:nth-child(2), tr td:nth-child(10):not([style*='border: 0px']) li:nth-child(2), tr td:nth-child(11):not([style*='border: 0px']) li:nth-child(2), tr td:nth-child(12):not([style*='border: 0px']) li:nth-child(2) {color: #1e5aaf;}"
end

def create_head(f)
	f.puts "<!DOCTYPE html>"
	f.puts "<html lang=\"en\">"
	f.puts "<head>"
	f.puts "\t<meta charset=\"UTF-8\">"
	f.puts "\t<title>Periodic Table</title>"
	f.puts "\t<link rel=\"stylesheet\" href=\"periodic_table.css\">"
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
	f.puts "\t<h1 style=\"text-align:center; margin: 0;\"><u>Periodic Table</u></h1>"
	f.puts "\t<h2 style=\"text-align:center; margin: 0;\">Mendeleïev</h2>"
	f.puts "\t<h3 style=\"text-align:center;margin: 0 0 8px; \">by tchartie</h3>"
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
	style = File.join(File.dirname(__FILE__), 'periodic_table.css')
	elements = parse_table

	File.open(file, 'w') do |f|
		create_head(f)
		create_body(f, elements)
	end

	File.open(style, 'w') do |f|
		create_style(f)
	end
end

main