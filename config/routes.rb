Rails.application.routes.draw do
  get 'home/index'
  root to: 'home#index'

  resources :posts, only: %i(index show) do
    patch :dissmiss,      on: :member
    patch :dissmiss_all,  on: :collection
    get :new_posts,       on: :collection
  end
end
