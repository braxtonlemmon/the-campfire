require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers

	def setup
		@user =       users(:braxton)
		@other_user = users(:greg)
	end

	# test show
	test 'should redirect show when not logged in' do
		get user_path @user
		assert_redirected_to new_user_session_path
	end

  # test 
	test 'should redirect index when not logged in' do
		get users_path
		assert_redirected_to new_user_session_path
	end

	test 'should show index of users when logged in' do
		sign_in @user
		get users_url
		assert_response :success
	end

	test 'should redirect edit when not logged in' do
		get edit_user_path(@user)
		assert_redirected_to new_user_session_path
	end

	test 'should redirect edit when logged in as wrong user' do
		sign_in @user
		get edit_user_path @other_user
		assert_redirected_to root_path
	end

	

	test 'should redirect update when not logged in' do
		patch user_path(@user), params: { user: { name:  @user.name,
																							email: @user.email } }
		assert_redirected_to new_user_session_path
	end																							

end
