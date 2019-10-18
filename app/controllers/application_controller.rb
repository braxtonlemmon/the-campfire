class ApplicationController < ActionController::Base
	include PublicActivity::StoreController
	
	protect_from_forgery with: :exception
	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :authenticate_user!
	before_action :get_activities

	def get_activities
		@activities = PublicActivity::Activity.order('created_at desc').where(owner_id: current_user.friend_ids, owner_type: 'User')
	end


	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :avatar])
	end
end
