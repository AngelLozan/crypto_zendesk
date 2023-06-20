Rails.application.routes.draw do
  get 'home/index'
  devise_for :users
  root to: "pages#home"
  resources :tickets, only: %i[show new create update]

  resources :tickets do
    get '/page/:page', action: :index, on: :collection
  end

  patch '/tickets/:id/assign', to: "tickets#assign", as: :assign_ticket

  # @dev Please leave in case of breaking changes.
  # resources :chatrooms, only: :show do
  #   resources :messages, only: :create
  # end

  resources :chatrooms, only: :show, param: :secret_url, path: '/chatrooms/'
  post '/chatrooms/:secret_url/messages', to: 'messages#create', as: 'chatroom_messages'

  get '/account', to: 'pages#account', as: :account
  get '/tickets/:id', to: 'tickets#show', as: 'show_ticket'
  get '/pricing', to: 'pricing#show', as: 'pricing'
end

