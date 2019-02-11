Rails.application.routes.draw do
  resources :orders
  resources :line_items
  put '/line_items/decrement/:id', to: 'line_items#decrement', as: 'line_item_decrement'
  put '/line_items/increment/:id', to: 'line_items#increment', as: 'line_item_increment'

  resources :carts
  get 'store/index'
  resources :products do
    get :download, on: :member
    get :who_bought, on: :member
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'store#index', as: 'store'



end
