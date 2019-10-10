Rails.application.routes.draw do
	root 'static_pages#home'
	devise_for :users, controllers: { sessions: 'users/sessions',
																		registrations: 'users/registrations' }
	resources :users do
		get 'friends', on: :member
	end
	
	resources :friend_requests
	resources :friendships
end
