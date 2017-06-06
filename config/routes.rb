Rails.application.routes.draw do
  root 'application#index'
  resources :debaters, only: [:index, :show]
  resource :schools, only: [:index, :show]

  namespace :api do
    jsonapi_resources :schools
    jsonapi_resources :debaters
  end
end
