require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers

	def setup
		@user =       users(:braxton)
		@other_user = users(:greg)
	end

	test 'should redirect show when not logged in' do
		get user_path @user
		assert_redirected_to new_user_session_path
	end

	test 'should show user page when logged in' do
		sign_in @user
		get user_path @other_user
		assert_response :success
	end
 
	test 'should redirect index when not logged in' do
		get users_path
		assert_redirected_to new_user_session_path
	end

	test 'should show index of users when logged in' do
		sign_in @user
		get users_url
		assert_response :success
	end
end
