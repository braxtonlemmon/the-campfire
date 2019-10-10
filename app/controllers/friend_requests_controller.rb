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
		request = FriendRequest.find(params[:id])
		@user = params[:inviter_id] ? request.inviter : request.invitee
		request.inviter.uninvite(request.invitee)
		redirect_to current_user if params[:inviter_id]
		respond_to do |format|
			format.html { redirect_to @user }
			format.js
		end
	end
end
