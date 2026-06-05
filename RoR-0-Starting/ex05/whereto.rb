def search_capitals(arg)
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
		puts "#{capital} is the capital of #{arg} (akr: #{states[arg]})"
	elsif state
		puts "#{arg} is the capital of #{state} (akr: #{capitals_cities.key(arg)})"
	else
		puts "#{arg} is neither a capital city nor a state"
	end
end

def main
	if ARGV.length() == 1
		search_capitals(ARGV[0])
	end
end

main
