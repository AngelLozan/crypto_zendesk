Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :tickets, only: [:index, :show, :new, :create, :update]

  # Custom route assign ticket to user GET `/tickets/:id/assign`, to: "tickets#assign", as: :assign_ticket

<<<<<<< HEAD
  # resources :profiles, only: [:show, :edit, :update, :new, :create]
=======
  resources :profiles, only: [:show, :edit, :update, :new, :create]
>>>>>>> master

  resources :chatrooms, only: :show do
    resources :messages, only: :create
  end

  get '/account', to: 'pages#account', as: :account
end
