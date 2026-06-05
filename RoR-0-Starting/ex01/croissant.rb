def main
	file = "numbers.txt"
	unless File.exist?(file)
		puts "#{file} not found"
		return
	end

	lines = File.readlines(file, "r").join.split("\n").map { |l| l.delete(",").to_i}
	lines.sort!
	for i in lines
		puts i
	end
end

main
