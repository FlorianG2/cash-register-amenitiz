Rails.application.routes.draw do
  root 'carts#show'
  resources :cart_products, only: %i[new create edit update index]
  delete 'cart_products', to: 'cart_products#destroy_all', as: :destroy_all
  delete 'cart_products/:id', to: 'cart_products#destroy', as: :destroy
end
