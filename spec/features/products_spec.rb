# frozen_string_literal: true

require 'rails_helper'

describe 'Products' do
  let!(:product_draft) { create(:product, status: 'draft', title: 'Novembro de 63') }
  let!(:product_active) { create(:product, status: 'active', title: 'O silêncio dos inocentes') }

  it 'Display all products' do
    visit products_path

    expect(page).to have_content(I18n.t('views.products'))
    expect(page).to have_content(product_draft.title)
    expect(page).to have_content(product_draft.category.name)

    expect(page).to have_content(product_active.title)
    expect(page).to have_content(product_active.category.name)
  end

  it 'Display only active products' do
    visit products_path(status: 'active')

    expect(page).to_not have_content(product_draft.title)
    expect(page).to_not have_content(product_draft.category.name)

    expect(page).to have_content(product_active.title)
    expect(page).to have_content(product_active.category.name)
  end

  it 'Display only draft products' do
    visit products_path(status: 'draft')

    expect(page).to have_content(product_draft.title)
    expect(page).to have_content(product_draft.category.name)

    expect(page).to_not have_content(product_active.title)
    expect(page).to_not have_content(product_active.category.name)
  end
end
