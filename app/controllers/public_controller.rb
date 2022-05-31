# frozen_string_literal: true

class PublicController < ApplicationController
  def home
    @products = Product.status('active')
  end
end
