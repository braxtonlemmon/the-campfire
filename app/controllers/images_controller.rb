class ImagesController < ApplicationController
	def new
		@image = Image.new
	end
	
	def create
		@image = current_user.images.build(image_params)
		if @image.save
			@image.create_activity :create, owner: current_user
			flash[:success] = 'Image uploaded!'
			redirect_to root_path
		else
			flash.now[:danger] = 'Error. Try again.'
			redirect_back fallback_location: root_path
		end
  end

	def destroy
				# @post.create_activity :destroy, owner: current_user
	end
	
	private

	def image_params
		params.require(:image).permit(:author_id, :image)
	end
end
