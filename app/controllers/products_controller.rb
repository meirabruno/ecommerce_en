# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @products = Product.all
    @products = filter_by_status
    @products = filter_by_title
    @products = order_products
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

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.update(permitted_params)
    @product.price = process_price
    @product.comparation_price = process_comparation_price
    @product.tags = process_tags

    validate_params

    @product.save!

    flash[:success] = I18n.t('products.flash.actions.update.notice')
    redirect_to action: :index
  rescue StandardError => e
    flash[:danger] = e.message
    render :edit
  end

  private

  def permitted_params
    params.require(:product).permit(:title, :status, :content, :category_id, images: [])
  end

  def process_price
    params[:product][:price].delete(',').delete('.') rescue nil
  end

  def process_comparation_price
    return nil if params[:product][:comparation_price].nil? || params[:product][:comparation_price].to_i.zero?

    params[:product][:comparation_price].delete(',').delete('.') rescue nil
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

  def filter_by_status
    return @products.status(params[:status]) if params[:status].present?

    @products
  end

  def filter_by_title
    return @products.by_title(params[:search]) if params[:search].present?

    @products
  end

  def order_products
    return @products.order(:created_at) if params[:field].blank?

    return @products.order(params[:field] => params[:order]) if params[:field] == 'title' || params[:field] == 'status'

    @products.includes(:category).order("categories.name #{params[:order]}")
  end
end
