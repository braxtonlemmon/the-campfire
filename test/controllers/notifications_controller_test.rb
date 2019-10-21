require 'test_helper'

class NotificationsControllerTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers

	def setup
		@user = users(:braxton)
	end

	test 'index should require user to be logged in' do
		get notifications_path
		assert_redirected_to new_user_session_path
	end

	test 'index should display when logged in' do
		sign_in @user
		get notifications_path
		assert_response :success
	end
end
