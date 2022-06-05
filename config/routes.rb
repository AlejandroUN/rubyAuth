Rails.application.routes.draw do
  resources :items
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
	resources :users
	resources :sessions

	get 'signup', to: 'users#new' , as:'signup'
	post 'register', to: 'users#create' , as:'register'
	get 'userInfo', to: 'users#get', as: 'userInfo'
	get 'signin', to: 'sessions#new', as: 'signin'
	post 'login', to: 'sessions#create' , as:'login'
	post 'history', to: 'sessions#history' , as:'history'
	post 'notifications', to: 'sessions#notifications' , as:'notifications'
end
