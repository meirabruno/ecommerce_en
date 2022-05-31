# frozen_string_literal: true

Rails.application.routes.draw do
  root 'public#home'

  resources :products, only: %i[index new create edit update show]
  resources :categories, only: %i[index new create]

  delete '/remove-products', to: 'products#remove_products', as: :remove_products
end
