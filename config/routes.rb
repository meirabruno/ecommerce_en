# frozen_string_literal: true

Rails.application.routes.draw do
  root 'products#index'

  resources :products
  resources :categories, only: [:index, :new, :create]
end
