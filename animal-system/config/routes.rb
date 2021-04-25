Rails.application.routes.draw do
  namespace :api, format: 'json' do
    namespace :v1 do
      namespace :elements do 
        get 'animal_types'
      end
    end
  end
end
