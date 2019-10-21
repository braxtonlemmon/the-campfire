require 'test_helper'

class FriendshipsControllerTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers

	def setup
		@user = users(:braxton)
		@other = users(:tommy)
	end

	test 'index should redirect if user not logged in' do
		get friendships_path
		assert_redirected_to new_user_session_path
	end

	test 'should redirect create when not logged in' do
		assert_no_difference 'Friendship.count' do
			post friendships_path, params: { friendships: { friend_id: @other.id,
																										 user_id: @user.id } }
		end	
	end
end
