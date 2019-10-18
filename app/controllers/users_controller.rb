class UsersController < ApplicationController
	def show
		@post = Post.new
		@user = User.find(params[:id])
		@posts = @user.feed.paginate(page: params[:page])
	end

	def index
		@users = User.where.not(id: current_user.id).paginate(page: params[:page])
	end
end
