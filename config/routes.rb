Rails.application.routes.draw do
	root "static_pages#index"
	get '/authorize', to: "sessions#authorize"
	get '/callback', to: "sessions#callback"
end
