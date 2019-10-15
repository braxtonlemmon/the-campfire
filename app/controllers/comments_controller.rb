class CommentsController < ApplicationController

	def create
		@post = Post.find(params[:comment][:commentable_id])
		if @post.comments.create(comment_params)
			flash[:success] = 'Successfully commented!'
			redirect_back fallback_location: root_path
		else
			flash[:warning] = 'Error'
			redirect_back fallback_location: root_path
		end
  end

  def destroy
  end
	
	private

	def comment_params
		params.require(:comment).permit(:content, :commentable_type, :commentable_id, :author_id)
	end
end
