class FriendRequestsController < ApplicationController
	
	def create
		@user = User.find(params[:invitee_id])
		current_user.invite(@user)
		redirect_back fallback_location: root_path
	end

	def destroy
		request = FriendRequest.find(params[:id])
		@user = params[:inviter_id] ? request.inviter : request.invitee
		request.inviter.uninvite(request.invitee)
		params[:inviter_id] ? (redirect_to current_user) : (redirect_back fallback_location: root_path)
	end
end
