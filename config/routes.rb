Rails.application.routes.draw do
  devise_for :users
  post 'signup' => 'users#create'
  post 'auth/login' => 'authentication#authenticate'
  resources :chats, only: [:index, :show, :create] do
    resources :messages, controller: 'chat_messages', only: [:index, :create]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
