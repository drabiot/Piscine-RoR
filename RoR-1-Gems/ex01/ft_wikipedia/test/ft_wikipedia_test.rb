$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'minitest/autorun'
require 'ft_wikipedia'

class Ft_wikipediaTest < Minitest::Test
	def test_search_philosophy
		assert_equal 0, Ft_wikipedia.search("Philosophy")
	end

	def test_search_dead_end
  		assert_nil Ft_wikipedia.search("NonExistingPage")
	end

	def test_search_loop
  		assert_nil Ft_wikipedia.search("Kiss")
	end

	def test_search_working
		assert_equal 1, Ft_wikipedia.search("Epistemology")
	end
end