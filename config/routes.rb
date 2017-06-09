Rails.application.routes.draw do
  resources :schools
  resources :judges
  resources :teams
  resources :debaters
  resources :rooms
  root 'application#index'
end
