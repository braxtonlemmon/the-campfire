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

	test 'capitalize_name should run' do
		@user.name = 'fred'
		@user.save
		assert_equal @user.name, 'Fred'
	end

	test 'associated posts should be destroyed' do
		@user.save
		@user.posts.create!(content: 'blah blah')
		assert_difference 'Post.count', -33 do
			@user.destroy
		end
	end

	test 'should invite and uninvite other user' do
		tommy = users(:tommy)
		dallin = users(:dallin)
		assert_not tommy.invited?(dallin)
		tommy.invite(dallin)
		assert tommy.invited?(dallin)
		tommy.uninvite(dallin)
		assert_not tommy.invited?(dallin)
	end

	test 'should add friend' do
		tommy = users(:tommy)
		dallin = users(:dallin)
		assert_not tommy.friends?(dallin)
		tommy.add_friend(dallin)
		assert tommy.friends?(dallin)
	end

	test 'feed should have right posts' do
		braxton = users(:braxton)
		greg    = users(:greg)
		tommy   = users(:tommy)

		greg.posts.each do |post|
			assert braxton.feed.include?(post)
		end

		braxton.posts.each do |post|
			assert braxton.feed.include?(post)
		end

		tommy.posts.each do |post|
			assert_not braxton.feed.include?(post)
		end
	end
end
