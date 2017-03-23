Rails.application.routes.draw do
  get 'photos/upload'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # api
  resources :photos, only: [:index, :create]

  post '/upload' => 'photos#upload'
  get '/apitest/:id' => 'photos#apitest'

end
