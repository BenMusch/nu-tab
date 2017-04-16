Rails.application.routes.draw do
  resources :debaters
  get 'debaters/index'

  get 'debaters/create'

  get 'debaters/show'

  get 'debaters/update'

  get 'debaters/destroy'

  root 'application#index'
  resources :schools, only: [:index, :create, :show, :update, :destroy]
end
