Competitions::Application.routes.draw do
  devise_for :users

  resources :competitions
  root to: 'competitions#index'
end
