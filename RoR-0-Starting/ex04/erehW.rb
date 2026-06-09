#!/usr/bin/env ruby

def search_states(capital)
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

	state = states.key(capitals_cities.key(capital))
	if state
		puts state
	else
		puts "Unknown capital city"
	end
end

def main
	if ARGV.length() == 1
		search_states(ARGV[0])
	end
end

main
