#!/usr/bin/env -S ruby -w

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

	arg = arg.split(/ |\_/).map(&:capitalize).reject(&:empty?).join(" ").strip
	if arg.empty?
		return
	end

	capital = capitals_cities[states[arg]]
	state = states.key(capitals_cities.key(arg))
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
		args = ARGV[0].split(",")
		for i in args
			search_arg(i)
		end
	end
end

main
