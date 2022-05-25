# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(permitted_params)

    if @product.save!
      flash[:success] = I18n.t('products.flash.actions.create.notice')
      redirect_to action: :index
    else
      flash[:danger] = I18n.t('products.flash.actions.create.danger')
      render :new
    end
  end
end
