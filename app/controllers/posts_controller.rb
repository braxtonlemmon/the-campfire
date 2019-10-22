class PostsController < ApplicationController
	before_action :correct_user, only: [:create]
	before_action :correct_post, only: [:destroy]

	def create
		@post = current_user.posts.build(post_params)
		if @post.save
			@post.create_activity :create, owner: current_user
			flash[:success] = 'Post created!'
			redirect_to root_path
		else
			flash.now[:danger] = 'Error. Try again.'
			redirect_back fallback_location: root_path
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		flash[:success] = 'Post deleted!'
		redirect_back fallback_location: root_path
	end

	private

	def post_params
		params.require(:post).permit(:content, :author_id, :image)
	end

	def correct_post
		@post = current_user.posts.find_by(id: params[:id])
		redirect_to root_path if @post.nil?
	end

	def correct_user
		@user = User.find(params[:post][:author_id])
		redirect_to root_path unless @user == current_user
	end
end
