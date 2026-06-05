def search_arg(arg)
	states = {
		"Oregon" => "OR",
		"Alabama" => "AL",
		"New Jersey" => "NJ",
		"Colorado" => "CO"
	}
	capitals_cities = {
		"OR" => "Salem",
		"AL" => "Montgomery",
		"NJ" => "Trenton",
		"CO" => "Denver"
	}

	capital = capitals_cities[states[arg.capitalize]]
	state = states.key(capitals_cities.key(arg.capitalize))
	if capital
		puts "#{capital} is the capital of #{arg.capitalize} (akr: #{states[arg.capitalize]})"
	elsif state
		puts "#{arg.capitalize} is the capital of #{state} (akr: #{capitals_cities.key(arg.capitalize)})"
	else
		puts "#{arg.capitalize} is neither a capital city nor a state"
	end
end

def main
	if ARGV.length() == 1
		args = ARGV[0].delete(" ").split(",").reject(&:empty?)
		for i in args
			search_arg(i)
		end
	end
end

main
