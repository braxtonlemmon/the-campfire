class CommentsController < ApplicationController

	def create
		@post = Post.find(params[:comment][:commentable_id])
		@comment = @post.comments.build(comment_params)
		if @comment.save
			@comment.create_activity :create, owner: current_user
			flash[:success] = 'Successfully commented!'
			redirect_back fallback_location: root_path
		else
			flash[:warning] = 'Error'
			redirect_back fallback_location: root_path
		end
  end

	def destroy
				# @comment.create_activity :destroy, owner: current_user

  end
	
	private

	def comment_params
		params.require(:comment).permit(:content, :commentable_type, :commentable_id, :author_id)
	end
end
