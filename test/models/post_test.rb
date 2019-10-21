require 'test_helper'

class PostTest < ActiveSupport::TestCase
	def setup
	  @post = posts(:climbing)
	end

	test 'should be valid' do
		assert @post.valid?
	end

	test 'should require content' do
		@post.content = ''
		assert_not @post.valid?
	end
	
	test 'content should not be longer than 10000 characters' do
		@post.content = 'a' * 10001
		assert_not @post.valid?
	end

	test 'associated likes should be destroyed' do
		user = users(:dallin)
		user.likes.create!(post_id: @post.id)
		assert_difference 'Like.count', -1 do
			@post.destroy 
		end
	end

	test 'associated comments should be destroyed' do
		greg = users(:greg)
		@post.comments.create!(content: 'woah', author: greg )
		assert_difference 'Comment.count', -1 do
			@post.destroy 
		end
	end

	test 'all_comments should show all comments' do
		greg = users(:greg)
		@post.comments.create!(content: 'one', author: greg)
		@post.comments.create!(content: 'two', author: greg)
		assert_equal @post.all_comments.count, 2
	end
end
