Rails.application.routes.draw do
  root 'application#home'
  # resources :songs, :playlists, :users

  resources :users, only: [:create, :show, :edit, :update, :destroy] do
    resources :playlists, only: [:create, :edit, :show, :destroy] do
      post 'search', to: 'playlists#search'
      resources :playlist_songs
    end
  end

  get '/login', to: 'users#login'
  post '/login', to: 'users#post_login'

  get '/signup', to: 'users#signup'
  post '/signup', to: 'users#create'

  post '/logout', to: 'users#logout'

  post '/search_by_mood', to: 'application#search_by_mood'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
