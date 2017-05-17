Rails.application.routes.draw do
  get 'photos/upload'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # api
  resources :photos, only: [:index, :create, :update]

  get '/photos/favorite/:id' => 'photos#favorite'
  get '/photos/unfavorite/:id' => 'photos#unfavorite'

  get '/photos/tweet' => 'photos#tweet'



  # test
  post '/upload' => 'photos#upload'
  get '/apitest/:id' => 'photos#apitest'

end
