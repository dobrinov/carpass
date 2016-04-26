Rails.application.routes.draw do

  resources :cars do
    resources :histories, shallow: true, only: [:new, :show, :destroy]

    resources :annual_inspection_histories, shallow: true,    except: [:index]
    resources :compulsory_insurance_histories, shallow: true, except: [:index]
    resources :production_histories, shallow: true,           except: [:index, :new, :create, :destroy]
    resources :purchase_histories, shallow: true,             except: [:index, :new, :create, :destroy]
    resources :full_insurance_histories, shallow: true,       except: [:index]
    resources :maintenance_histories, shallow: true,          except: [:index]
    resources :repairment_histories, shallow: true,           except: [:index]
    resources :tax_histories, shallow: true,                  except: [:index]
    resources :tuning_histories, shallow: true,               except: [:index]
    resources :vignette_histories, shallow: true,             except: [:index]
    resources :tyre_histories, shallow: true,                 except: [:index]

    namespace :statistics do
      get '/last_year', to: 'expenses#last_year'
      get '/all_time',  to: 'expenses#all_time'

      root to: 'expenses#all_time'
    end
  end

  # Omniauth
  get    '/auth/facebook/callback',   to: 'facebook_sessions#create'
  get    '/auth/failure',             to: 'static_pages#landingpage'
  get    '/signin',                   to: 'sessions#new'
  get    '/signup',                   to: 'users#new'
  post   '/signup',                   to: 'users#create'
  post   '/signin',                   to: 'sessions#create'
  delete '/signout',                  to: 'sessions#destroy'
  get    '/profile',                  to: 'users#show'
  get    '/profile/edit',             to: 'users#edit'
  patch  '/profile',                  to: 'users#update'
  get    '/profile/password/edit',    to: 'passwords#edit'
  patch  '/profile/password',         to: 'passwords#update'

  get '/contacts',     to: 'static_pages#contacts'
  get '/terms_of_use', to: 'static_pages#terms_of_use'

  namespace :admin do
    resources :users, only: [:index] do
      resources :cars, only: [:index]
    end

    resources :cars, only: [] do
      resources :histories, only: [:index]
    end

    namespace :statistics do
      get '/users/overview', to: 'users#overview'
      get '/users/signups', to: 'users#signups'
      get '/users/signins', to: 'users#signins'

      get '/car/creations', to: 'cars#creations'

      get '/history/creations', to: 'histories#creations'

      root to: 'base#overview'
    end

    root to: "users#index"
  end

  root to: "static_pages#landingpage"
end
