Rails.application.routes.draw do
  root to: 'posts#index'

  resources :posts, only: %i(index show) do
    patch :dissmiss,      on: :member
    patch :dissmiss_all,  on: :collection
    get :new_posts,       on: :collection
  end
end
