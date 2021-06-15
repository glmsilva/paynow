Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  #resources 'companies'
  namespace :admin do
    get 'index', to: 'home#index'
    resources :companies, only: %i[edit update show index] do 
      post 'inactivate', on: :member
      post 'change_token', on: :member
    end
    get 'charges', to: 'charges#index'
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
    resources :companies, only: %i[new create]
  end
end
