Rails.application.routes.draw do
  namespace :api, format: 'json' do
    namespace :v1 do
      resources :animals, only: [:index] 
      namespace :animals do 
        get 'animal_types'
      end

      resources :countories, only: [:index] 
    end
  end
end
