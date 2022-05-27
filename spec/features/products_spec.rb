# frozen_string_literal: true

require 'rails_helper'

describe 'Products' do
  let!(:product) { create(:product) }
  it 'Display products' do
    visit products_path

    expect(page).to have_content(I18n.t('views.products'))
    expect(page).to have_content(product.title)
    expect(page).to have_content(product.status)
    expect(page).to have_content(product.category.name)
  end
end
