class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
		@posts = Post.where('author_id = ?', @user.id)
	end

	def friends
		@user = User.find(params[:id])
	end

	def index
		@users = User.all 
	end
end
