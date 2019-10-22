require 'test_helper'

class PostsTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers

	def setup
		@user = users(:braxton)
		sign_in @user
	end

	test 'post interface' do
		get root_path
		assert_select 'div.pagination'
		assert_select 'input[type=file]'
	end

	test 'invalid submission' do
		assert_no_difference 'Post.count' do
			post posts_path, params: { post: { content: '',
																				 author_id: @user.id } }
		end
	end

	test 'valid submission' do
		assert_difference 'Post.count', 1 do
			post posts_path, params: { post: {content: 'blah blah',
																			  author_id: @user.id } }
		end
	end

	test 'valid destroy' do
		assert_difference 'Post.count', -1 do
			delete post_path(@user.posts.first)
		end
	end
end
