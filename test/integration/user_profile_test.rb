require 'test_helper'

class UserProfileTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers

	def setup
		@user = users(:braxton)
	end

	test 'profile display of current user' do
		sign_in @user
		get user_path(@user)
		assert_response :success
		assert_select 'title', @user.name
		assert_select 'h2', @user.name
		assert_select 'div.avatar'
		assert_select '.btn'
		assert_select 'form'
		assert_match @user.feed.last.content, response.body
	end

end
