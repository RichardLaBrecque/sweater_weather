Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/forecast', to: 'forecast#show'
      get '/backgrounds', to: 'background#show'
      get '/munchies', to: 'munchies#show'
      post '/users', to: 'user#create'
      post '/sessions', to: 'user#login'
      post '/road_trip', to: 'road_trip#create'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
