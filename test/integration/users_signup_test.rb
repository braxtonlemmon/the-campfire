require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers

	test 'sign up with invalid information' do
		get new_user_registration_path
		assert_response :success
		assert_no_difference 'User.count' do
			post users_path, params: { user: { name: '',
																				email: '',
																				password: 'foo',
																				password_confirmation: 'bar'
			} }
		end
		assert_template 'users/registrations/new'
	end

	test 'sign up with valid information' do
		get new_user_registration_path
		assert_response :success
		assert_difference 'User.count', 1 do
			post users_path, params: { user: { name:     'Bob',
																				 email:    'bob@email.com',
																				 password: 'password',
																				 password_confirmation: 'password'} }
		end
	end
end
