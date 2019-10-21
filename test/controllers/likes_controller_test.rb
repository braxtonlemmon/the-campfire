require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers

	test 'should require login to create' do
		assert_no_difference 'Like.count' do
			post likes_path
		end
		assert_redirected_to new_user_session_path
	end

	test 'should require login to destroy' do
		assert_no_difference 'Like.count' do
			delete like_path(likes(:one))
		end
		assert_redirected_to new_user_session_path
	end
end
