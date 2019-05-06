Rails.application.routes.draw do
  devise_for :users
  post 'signup' => 'users#create'
  get 'users' => 'users#index'
  post 'auth/login' => 'authentication#authenticate'
  resources :chats, only: [:index, :show, :create] do
    resources :messages, controller: 'chat_messages', only: [:index, :create]
  end
  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
