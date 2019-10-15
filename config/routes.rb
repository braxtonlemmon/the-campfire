Rails.application.routes.draw do
  get 'comments/new'
  get 'comments/create'
  get 'comments/destroy'
  get 'comments/index'
	root 'static_pages#home'
	devise_for :users, controllers: { sessions: 'users/sessions',
																		registrations: 'users/registrations',
																		omniauth_callbacks: 'users/omniauth_callbacks' }
																	
	resources :users do
		get 'friends', on: :member
	end
	
	resources :friend_requests
	resources :friendships
	resources :notifications
	resources :posts
	resources :likes
	resources :comments
end
