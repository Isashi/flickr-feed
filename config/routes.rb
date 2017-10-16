Rails.application.routes.draw do
	root "static_pages#index"
	get '/authorize', to: "static_pages#authorize"
	get '/callback', to: "static_pages#callback"
end
