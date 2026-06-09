#!/usr/bin/env -S ruby -w

def hashing(array)
	hash = Hash.new
	
	array.each do |name, score|
		hash[name] = score
	end

	return hash
end

def main
	data = [['Frank', 33],
			['Stacy', 15],
			['Juan' , 24],
			['Dom' , 32],
			['Steve', 24],
			['Jill' , 24]]

	hash = hashing(data)
	sorted_hash = hash.sort_by { |key, value| [value, key] }

	sorted_hash.each { |key, value| puts "#{key}" }
end

main
