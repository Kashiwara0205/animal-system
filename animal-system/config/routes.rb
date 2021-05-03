Rails.application.routes.draw do
  # API
  namespace :api, format: 'json' do
    namespace :v1 do
      resource :animals,  only: [:update]
      resources :animals, only: [:index]
      namespace :animals do 
        get 'animal_types'
      end

      resources :countories, only: [:index] 
    end
  end

  # Index
  root 'top#index'
  resources :animals, only: [:index] 
end
