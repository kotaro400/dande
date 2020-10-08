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

    member do
      get :embed
      get :preview
    end
  end

  root "articles#index"
end