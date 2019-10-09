class FriendshipsController < ApplicationController
	before_action :authenticate_user!

	def create
		@other_user = User.find(params[:friend_id])
		current_user.add_friend(@other_user)
		redirect_to root_path
  end

  def destroy
  end
end
