$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'minitest/autorun'
require 'deepthought'

class DeepthoughtTest < Minitest::Test
	def test_new_returns_deepthought_instance
		dt = Deepthought.new
		assert_instance_of Deepthought, dt
	end

	def test_respond_with_ultimate_question
		dt = Deepthought.new
		assert_equal "42", dt.respond("The Ultimate Question of Life, the Universe and Everything")
	end

	def test_respond_with_other_question
		dt = Deepthought.new
		assert_equal "Mmmm i'm bored", dt.respond("What is your name?")
	end
end
