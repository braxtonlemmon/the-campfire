require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers 
	
	def setup
		@user = users(:braxton)
	end

	test 'unsuccessful edit' do
		sign_in @user
		get edit_user_registration_path(@user)
		assert_response :success
		patch user_registration_path, params: { user: { name: 'asdf',
																										email: 'bloo',
																										password: 'foo',
																										password_confirmation: 'bar',
																										current_password: 'bloof'															
																						 } }
		assert_template 'users/registrations/edit'	
	end

	test 'successful edit' do
		sign_in @user
		get edit_user_registration_path
		assert_response :success
		patch user_registration_path, params: { user: { name: 'Trevor',
																										email: @user.email,
																										password: '',
																										password_confirmation: '',
																										current_password: 'password' } }
		assert_response :redirect
		@user.reload
		assert_equal @user.name, 'Trevor'
	end																										
end
