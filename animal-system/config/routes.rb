Rails.application.routes.draw do
  # API
  namespace :api, format: 'json' do
    namespace :v1 do
      resource :animals,  only: [:update, :create]
      resources :animals, only: [:index]
      namespace :animals do 
        get 'animal_types'
        get 'csv'
      end

      resources :questions, only: [:index]

      resources :countories, only: [:index] 
    end
  end

  # Index
  root 'top#index'
  resources :animals, only: [:index]
  resources :questions, only: [:index] 
end
