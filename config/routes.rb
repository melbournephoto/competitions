Competitions::Application.routes.draw do
  devise_for :users

  resources :competitions do
    resources :sections
    resources :entries
  end

  namespace :judging do
    resources :entries
    resources :sessions
  end
  root to: 'competitions#index'
end
