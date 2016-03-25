Rails.application.routes.draw do
  get 'statics/index'

  devise_for :users

  root to: 'posts#index'

  resources :posts do
    collection do
      get :my_posts
    end
    resources :comments
  end

  resources :statics

  get 'tags/:tag', to: 'posts#index', as: :tag
end
