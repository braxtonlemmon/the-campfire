class PostsController < ApplicationController

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

	def edit
	end

	def update
	end

	def index
	end

	private

	def post_params
		params.require(:post).permit(:content, :author_id, :image)
	end
end
