# frozen_string_literal: true

class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(permitted_params)

    raise I18n.t('categories.flash.actions.create.danger.name') if permitted_params[:name].blank?

    @category.save!

    flash[:success] = I18n.t('categories.flash.actions.create.notice')
    redirect_to action: :index
  rescue StandardError => e
    flash[:danger] = e.message
    render :new
  end

  private

  def permitted_params
    params.require(:category).permit(:name)
  end
end
