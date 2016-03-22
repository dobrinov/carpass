Rails.application.routes.draw do

  resources :cars do
    resources :histories, only: [:new, :create, :edit, :update, :destroy]
  end

  # Omniauth
  get    '/auth/facebook/callback',  to: 'facebook_sessions#create'
  get    '/auth/failure',            to: 'static_pages#landingpage'
  get    'signin',                   to: 'sessions#new'
  get    'signup',                   to: 'users#new'
  post   'signup',                   to: 'users#create'
  post   'signin',                   to: 'sessions#create'
  delete 'signout',                  to: 'sessions#destroy'

  root to: "static_pages#landingpage"
end
