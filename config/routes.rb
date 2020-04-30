Rails.application.routes.draw do


  resources :games , only: [:show, :create]

  post 'games/:id/shots', to: 'shots#create'

end
