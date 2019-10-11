class NotificationsController < ApplicationController
	def index
		@requests = current_user.passive_requests
		# @posts = posts from friends
		# @likes = likes from friends
		@notifications = @requests.count
	end
end
