Competitions::Application.routes.draw do
  devise_for :users

  resources :competitions do
    resources :sections
  end
  root to: 'competitions#index'
end
