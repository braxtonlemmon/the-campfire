class NotificationsController < ApplicationController
	def index
		@requests = current_user.passive_requests
		@notifications = @requests.count
	end
end
