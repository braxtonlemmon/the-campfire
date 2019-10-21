require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
	def setup
		@user = users(:braxton)
		@other_user = users(:tommy)
	end

	test 'created and destroyed friendship should be reciprocal' do
		assert_not @user.friends?(@other_user)
		Friendship.create_reciprocal_for_ids(@user.id, @other_user.id)
		assert @user.friends?(@other_user)
		assert @other_user.friends?(@user)
		Friendship.destroy_reciprocal_for_ids(@user.id, @other_user.id)
		assert_not @user.friends?(@other_user)
		assert_not @other_user.friends?(@user)	
	end
end
