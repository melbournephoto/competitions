Competitions::Application.routes.draw do
  devise_for :users

  resources :competitions do
    resources :sections
    resources :entries
    resources :email_judging_links
  end

  resources :users

  resources :competition_series_grades

  namespace :judging do
    resources :entries
    resources :sessions
  end
  root to: 'competitions#index'
end
