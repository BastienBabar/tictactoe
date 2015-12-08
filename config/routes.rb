Rails.application.routes.draw do
  root :to =>  'game#new'

  post 'game', :to =>  'game#init', as: :init

  get 'game/over', :to => 'game#over', as: :over

  post 'game/turn', :to => 'game#turn', as: :turn
end
