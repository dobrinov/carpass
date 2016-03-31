Rails.application.routes.draw do

  resources :cars do
    resources :histories, only: [:new]

    resources :annual_inspection_histories,    only: [:new, :create]
    resources :compulsory_insurance_histories, only: [:new, :create]
    resources :full_insurance_histories,       only: [:new, :create]
    resources :maintenance_histories,          only: [:new, :create]
    resources :repairment_histories,           only: [:new, :create]
    resources :tax_histories,                  only: [:new, :create]
    resources :tuning_histories,               only: [:new, :create]
    resources :vignette_histories,             only: [:new, :create]
    resources :tyre_histories,                 only: [:new, :create]
  end

  # Omniauth
  get    '/auth/facebook/callback',  to: 'facebook_sessions#create'
  get    '/auth/failure',            to: 'static_pages#landingpage'
  get    'signin',                   to: 'sessions#new'
  get    'signup',                   to: 'users#new'
  post   'signup',                   to: 'users#create'
  post   'signin',                   to: 'sessions#create'
  delete 'signout',                  to: 'sessions#destroy'

  get 'contacts',     to: 'static_pages#contacts'
  get 'terms_of_use', to: 'static_pages#terms_of_use'

  namespace :admin do
    resources :users, only: [:index] do
      resources :cars, only: [:index]
    end

    resources :cars, only: [] do
      resources :histories, only: [:index]
    end

    root to: "users#index"
  end

  root to: "static_pages#landingpage"
end
