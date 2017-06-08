Rails.application.routes.draw do
  resources :schools
  root 'application#index'
end
