Rails.application.routes.draw do
  resources :schools
  resources :judges
  resources :teams
  resources :debaters
  root 'application#index'
end
