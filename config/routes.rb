Rails.application.routes.draw do
  get 'home/index'
  devise_for :users
  root to: "pages#home"
  resources :tickets, only: %i[index show new create update]

  get '/tickets/:id/assign', to: "tickets#assign", as: :assign_ticket

  # patch '/tickets/:ticket_id/users/:user_id', to: "tickets#assign", as: :assign_ticket_to_user #no more than two keys nested. Or else use form.

  # resources :profiles, only: [:show, :edit, :update, :new, :create]

  resources :chatrooms, only: :show do
    resources :messages, only: :create
  end

  get '/account', to: 'pages#account', as: :account
  get '/tickets/:id', to: 'tickets#show', as: 'show_ticket'
end
