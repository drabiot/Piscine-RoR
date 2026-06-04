def main
	lines = File.readlines("numbers.txt", "r").join.split("\n").map { |l| l.delete(",").to_i}
	lines.sort!
	for i in lines
		puts i
	end
end

main