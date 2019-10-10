class FriendRequestsController < ApplicationController
	before_action :authenticate_user!

	def create
		@user = User.find(params[:invitee_id])
		current_user.invite(@user)
		respond_to do |format|
			format.html { redirect_to @user }
			format.js
		end
	end

	def destroy
		@user = FriendRequest.find(params[:id]).invitee 
		current_user.uninvite(@user)
		respond_to do |format|
			format.html { redirect_to @user }
			format.js
		end
	end
end
