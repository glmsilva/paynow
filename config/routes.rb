Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  resources :receipts, param: :slug, only: %i[show]
  #resources 'companies'
  namespace :admin do
    get 'index', to: 'home#index'
    resources :companies, only: %i[edit update show index] do 
      post 'inactivate', on: :member
      get 'show_inactivates', on: :collection
      post 'activate', on: :member
      post 'change_token', on: :member
    end
    resources :charges, only: %i[index show] do 
      post 'approve', on: :member
    end
    get 'pendentes', to: 'charges#pending'
    resources :payment_methods, only: %i[index]
    resources :credit_cards do 
      post 'inactivate', on: :member
      post 'activate', on: :member
    end
    resources :boletos do 
      post 'inactivate', on: :member
      post 'activate', on: :member
    end
    resources :pixes do 
      post 'inactivate', on: :member
      post 'activate', on: :member
    end
    
  end

  namespace :employees do
    get 'index', to: 'home#index'
    get 'metodos_pagamento', to: 'payment_methods_companies#index'
    resources :payment_methods, only: %i[index] do 
      resources :payment_methods_companies, only: %i[create update show] do 
        post 'inactivate', on: :member
      end
    end
    resources :companies, only: %i[new create]
    resources :products, only: %i[index create edit update show]
  end

  namespace :api do 
    namespace :v1 do 
      resources :customers
      resources :charges, only: %i[create index]
      put 'charges',param: :token, to: 'charges#update'
    end
  end
end
