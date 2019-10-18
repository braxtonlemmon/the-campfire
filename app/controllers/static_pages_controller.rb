class StaticPagesController < ApplicationController
	skip_before_action :authenticate_user!

	def home
		if user_signed_in?
			@post = current_user.posts.build
			@posts = current_user.feed
			@image = current_user.images.build
		end
	end
	
	private
end
