Competitions::Application.routes.draw do
  devise_for :users

  resources :competitions do
    resources :sections
    resources :entries
  end

  resources :pages

  namespace :admin do
    resources :competitions do
      resources :sections
      resources :email_judging_links
    end
    resources :download_competitions
    resources :entries
    resources :users
  end

  resources :competition_series_grades

  namespace :judging do
    resource :download_entries
    resources :entries
    resources :sessions
  end
  root to: 'competitions#index'
end
