Rails.application.routes.draw do
  get 'home/index'
  root to: 'home#index'

  resources :posts, only: %i(index show)
end
