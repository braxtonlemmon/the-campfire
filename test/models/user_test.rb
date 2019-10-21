require 'test_helper'

class UserTest < ActiveSupport::TestCase
	def setup
		@user = users(:braxton)
	end

	test 'should be valid' do 
		assert @user.valid?
	end

	test 'name should be present' do
		@user.name = ''
		assert_not @user.valid?
	end

	test 'name should not be too long' do
		@user.name = 'b' * 45
		assert_not @user.valid?
	end

	test 'capitalize_name should work' do
		@user.name
end
