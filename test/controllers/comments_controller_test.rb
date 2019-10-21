require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers

	def setup
		@comment = comments(:one)
		@post = posts(:orange_juice)
		@user = users(:braxton)
	end

	test 'should create a comment' do
		sign_in @user
		assert_difference 'Comment.count', 1 do
			post comments_path, params: { comment: { content: 'Cool',
																							 commentable_id: @post.id,
																							 author_id: @user.id } }
		end
	end

	test 'should destroy a comment' do
		comment = comments(:one)
		sign_in @user
		assert_difference 'Comment.count', -1 do
			delete comment_path(comment)
		end
	end
end
