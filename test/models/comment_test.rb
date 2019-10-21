require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  
	def setup
		@comment = comments(:one)
	end

	test 'should be valid' do
		assert @comment.valid?
	end

	test 'should not exceed 5000 characters' do
		@comment.content = 'a' * 5001
		assert_not @comment.valid?
	end

	test 'should find author' do
		user = users(:greg)
		assert_equal @comment.author, user
	end 
end
