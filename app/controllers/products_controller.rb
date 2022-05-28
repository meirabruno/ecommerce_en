# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @products = if params[:status].present?
                  Product.status(params[:status])
                else
                  Product.all
                end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(permitted_params)
    @product.price = process_price
    @product.comparation_price = process_comparation_price
    @product.tags = process_tags

    validate_params

    @product.save!

    flash[:success] = I18n.t('products.flash.actions.create.notice')
    redirect_to action: :index
  rescue StandardError => e
    flash[:danger] = e.message
    render :new
  end

  private

  def permitted_params
    params.require(:product).permit(:title, :status, :content, :category_id, images: [])
  end

  def process_price
    params[:product][:price].delete(',')
  end

  def process_comparation_price
    return nil if params[:product][:comparation_price].nil? || params[:product][:comparation_price].to_i.zero?

    params[:product][:comparation_price].delete(',')
  end

  def process_tags
    return nil if params[:product][:tags].blank?

    params[:product][:tags].split(',')
  end

  def validate_comparation_price
    process_comparation_price.present? && process_price <= process_comparation_price
  end

  def validate_params
    raise I18n.t('products.flash.actions.create.danger.title') if permitted_params[:title].blank?
    raise I18n.t('products.flash.actions.create.danger.description') if permitted_params[:content].blank?
    raise I18n.t('products.flash.actions.create.danger.status') if permitted_params[:status].blank?
    raise I18n.t('products.flash.actions.create.danger.price') if params[:product][:price].blank?
    raise I18n.t('products.flash.actions.create.danger.category') if permitted_params[:category_id].blank?
    raise I18n.t('products.flash.actions.create.danger.comparation_price') if validate_comparation_price
  end
end
