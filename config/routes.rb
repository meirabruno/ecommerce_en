# frozen_string_literal: true

Rails.application.routes.draw do
  root 'products#index'

  resources :products, only: %i[index new create edit update]
  resources :categories, only: %i[index new create]

  delete '/remove-products', to: 'products#remove_products', as: :remove_products
end
