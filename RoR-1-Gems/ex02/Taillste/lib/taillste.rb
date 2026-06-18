#!/usr/bin/env -S ruby -w

require_relative "taillste/version"

module Taillste
	class Drum
		attr_reader :beat

		def initialize
			@beat = [1,4,9]
		end

		def shuffle
			return @beat.rotate(2)
		end

		def count
			return (@beat.min..@beat.max).map { |i| @beat.include?(i) ? i.to_s : "." }.join("\n") + "\n"
		end

		def played_with
			return "Both arms and legs"
		end
	end

	class Beat_box < Drum
		def initialize
			@beat = [1,5,7]
		end

		def shuffle
			return @beat.reverse
		end

		def played_with
			return "Mouth"
		end
	end

	class Clap < Drum
		def initialize
			@beat = [2,3,7,8]
		end

		def shuffle
			return @beat.shuffle
		end

		def played_with
			return "Both_hands"
		end
	end
end
