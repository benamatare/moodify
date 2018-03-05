Rails.application.routes.draw do
  root 'application#home'
  resources :songs, :playlists, :users
    get '/login', to: 'users#login'
    post '/login', to: 'users#post_login'

    get '/signup', to: 'users#signup'
    post '/signup', to: 'users#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
