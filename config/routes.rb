Rails.application.routes.draw do
  get 'pages/game'
  root 'pages#game'
  
  namespace :api do
    namespace :v1 do
      resources :scores, only: [:index, :create, :destroy]
      resources :photos, only: [:index, :show]
      resources :subjects, only: [:show]
      resources :target_boxes, only: [:show]
    end
  end
end
