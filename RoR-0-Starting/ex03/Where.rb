def search_capitals(state)
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

	capital = capitals_cities[states[state.capitalize]]
	if capital
		puts capital
	else
		puts "Unknown state"
	end
end

def main
	if ARGV.length() == 1
		search_capitals(ARGV[0])
	end
end

main
