class UsersController < ApplicationController
	before_action :correct_user, only: [:edit, :update]
	
	def show
		@post = Post.new
		@user = User.find(params[:id])
		@posts = @user.feed.paginate(page: params[:page])
	end

	def index
		@users = User.where.not(id: current_user.id).paginate(page: params[:page])
	end

	private

	def correct_user
		@user = User.find(params[:id])
		redirect_to root_path unless @user == current_user
	end
end
