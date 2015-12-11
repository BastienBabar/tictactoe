Rails.application.routes.draw do
  root :to =>  'game#new'

  post 'game', :to =>  'game#init', as: :init

  post 'game/turn', :to => 'game#turn', as: :turn
end
