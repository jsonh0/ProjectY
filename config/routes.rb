Rails.application.routes.draw do
  resources :documents do
    post 'sent', on: :collection
    post 'add_receipt', on: :collection
  end
  resources :immigration_cases
  resources :foreign_nationals
  resources :accounts 
  devise_for :users
  resources :accesses
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  root "accounts#index"

end
 