Rails.application.routes.draw do
  root to: 'application#index'

  resources :schools

  resources :scratches, only: [:new, :create]

  resources :judges do
    resources :scratches, only: [:index]
  end

  resources :teams do
    resources :scratches, only: [:index]
  end

  resources :debaters

  resources :rooms
end
