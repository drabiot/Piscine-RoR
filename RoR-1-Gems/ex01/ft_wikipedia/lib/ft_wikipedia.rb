#!/usr/bin/env -S ruby -w

require 'open-uri'
require 'nokogiri'

class Ft_wikipedia
	def self.find_first_link(ref)
		ref.css('> p a').each do |a|
			href = a['href']
			next unless href
			next unless href.start_with?("/wiki/")
			next if href.include?(":")
			next if a['class'] && a['class'].include?("new")
			return href.sub("/wiki/", "")
		end
		nil
	end

	def self.search(link)
		count = 0
		current = link
		visited = []

		loop do
			url = URI.open("https://en.wikipedia.org/wiki/#{current}")

			if count == 0
				puts "First search @ :https://en.wikipedia.org/wiki/#{current}"
			else
				puts "https://en.wikipedia.org/wiki/#{current}"
			end

			if visited.include?(current)
				puts "Loop detected there is no way to philosophy here"
				raise StandardError
			end
			visited << current

			return count if current == "Philosophy"

			page = Nokogiri::HTML(url)
			ref = page.at_css("#mw-content-text .mw-parser-output")

			next_link = find_first_link(ref)

			if next_link.nil?
				puts "Dead end page reached"
				raise StandardError
			end

			current = next_link
			count += 1
		end
	rescue StandardError
		nil
	end
end