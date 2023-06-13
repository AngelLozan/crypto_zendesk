Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :tickets, only: [:index, :show, :new, :create, :edit, :update]

  resources :users do
    resources :tickets, only: [:assign]
  end

  resources :profiles, only: [:show, :edit, :update, :new, :create]
  
  resources :chatrooms, only: :show do
    resources :messages, only: :create
  end

end
