class NotificationsController < ApplicationController
	def index
		@requests = current_user.passive_requests.paginate(page: params[:page])
		@notifications = @requests.count
	end
end
