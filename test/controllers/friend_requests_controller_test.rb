require 'test_helper'

class FriendRequestsControllerTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers

	def setup
		@user = users(:braxton)
		@other = users(:tommy)
	end

	test 'should require login to create' do
		assert_no_difference 'FriendRequest.count' do
			post friend_requests_path
		end
		assert_redirected_to new_user_session_path
	end

	test 'should require login to destroy' do
		assert_no_difference 'FriendRequest.count' do 
			delete friend_request_path(friend_requests(:one))
		end
		assert_redirected_to new_user_session_path
	end
end
