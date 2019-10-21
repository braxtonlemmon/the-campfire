require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers

	def setup
		@user = users(:braxton)
	end

	test 'layout links without sign in' do
		get root_path
		assert_template 'static_pages/home'
		assert_select 'a[href=?]', root_path, count: 1
		assert_select 'a[href=?]', new_user_registration_path
		assert_select 'a[href=?]', user_facebook_omniauth_authorize_path
		assert_select 'a[href=?]', "https://github.com/braxtonlemmon/"
	end

	test 'layout links after sign in' do
		sign_in @user
		get root_path
		assert_response :success
		assert_select 'a[href=?]', root_path, count: 2
		assert_select 'a[href=?]', notifications_path
		assert_select 'a[href=?]', friendships_path
		assert_select 'a[href=?]', users_path
		assert_select 'a[href=?]', user_path(@user)
		assert_select 'a[href=?]', edit_user_registration_path(@user.id)
		assert_select 'a[href=?]', destroy_user_session_path
		assert_select 'a[href=?]', "https://github.com/braxtonlemmon/"
	end
end
