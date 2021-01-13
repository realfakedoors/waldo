Rails.application.routes.draw do
  get  'pages/game'
  root 'pages#game'
  
  namespace :api do
    namespace :v1 do
      resources :photos, only: [:index, :show] 
      resources :photos do
        resources :subjects, only: [:index]
        resources :scores, only: [:index, :create]
      end
    end
  end
end
