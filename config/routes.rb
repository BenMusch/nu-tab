Rails.application.routes.draw do
  root 'application#index'
  resources :schools, only: [:index, :create, :show, :update, :destroy]
end
