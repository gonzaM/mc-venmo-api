Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  defaults format: :json do
    resources :users, only: [] do
      resources :payments, only: :create
      member do
        get :feed
        get :balance
      end
    end
  end
end
