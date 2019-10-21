Rails.application.routes.draw do
	root 'static_pages#home'
	devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
																	
	resources :users, only: [:show, :index] do
		get 'friends', on: :member
	end
	
	resources :friend_requests
	resources :friendships
	resources :notifications
	resources :posts, only: [:create, :destroy]
	resources :likes
	resources :comments
	resources :images
	resources :activities
	mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
