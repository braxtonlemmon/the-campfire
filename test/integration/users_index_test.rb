require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers

	def setup
		@user = users(:braxton)
		sign_in @user
	end

	test 'index with pagination' do
		get users_path
		assert_response :success
		assert_select 'div.pagination'
		first_page = User.paginate(page: 1)
		first_page.each do |user|
			assert_select 'a[href=?]', user_path(user)
		end
	end
end
