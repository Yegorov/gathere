Rails.application.routes.draw do
  devise_for :users
  resources :tasks do
    member do
      patch :up
      patch :down
    end
  end
  resources :projects

  root to: "projects#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
