Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :owners, skip: [:password, :registration], controllers: {
        sessions: 'owners/sessions'
      }

  resources :articles do
    collection do
      get :search
      get :draft
    end
  end

  resources :embedded_articles, only: [:show] do
    member do
      get :embed
    end
  end

  resources :tags, only: [:new, :create] do
    collection do
      get :search
    end
  end

  resources :features

  root "articles#index"
end
