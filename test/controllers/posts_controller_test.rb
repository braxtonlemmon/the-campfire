require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers
	
	def setup
		@post = posts(:banana)
	end

	test 'should redirect create when not logged in' do
		assert_no_difference 'Post.count' do
			post posts_path, params: { posts: { content: 'Board games rock' } }
		end
		assert_redirected_to new_user_session_path
	end

	test 'should redirect destroy when not logged in' do
		assert_no_difference 'Post.count' do
			delete post_path(@post)
		end
		assert_redirected_to new_user_session_path
	end

	test 'should redirect destroy for wrong post' do
		braxton = users(:braxton)
		sign_in braxton
		post = posts(:orange_juice)
		assert_no_difference 'Post.count' do
			delete post_path(post)
		end
	end

end
