require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers

	def setup
		@user = users(:braxton)
	end

	test 'login with invalid information' do
		get new_user_session_path
		assert_response :success
		post new_user_session_path,
			params: { user: { email: '',
												password: 'foobar' } }		
		assert_template 'users/sessions/new'
	end

	test 'login with valid information' do
		get new_user_session_path
		post new_user_session_path,
			params: { user: { email: @user.email,
												password: 'password' } }
		assert_response :redirect		
		follow_redirect!
		assert_template 'static_pages/home'
	end										
end
