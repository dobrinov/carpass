Rails.application.routes.draw do

  resources :cars do
    resources :histories, only: [:new, :create, :edit, :update, :destroy]
  end

  # Omniauth
  get    '/auth/:provider/callback', to: 'sessions#create'
  get    '/auth/failure',            to: 'static_pages#landingpage'
  get    'signin',                   to: 'sessions#new'
  post   'signin',                   to: 'sessions#create'
  delete 'signout',                  to: 'sessions#destroy'

  root to: "static_pages#landingpage"
end
