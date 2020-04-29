Rails.application.routes.draw do


  post 'games', to: 'games#create'
  get 'games/:id/score', to: 'games#score'

  post 'games/:id/shots', to: 'shots#create'

end
