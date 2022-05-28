# frozen_string_literal: true

require 'rails_helper'

describe 'Products' do
  context 'dispay products' do
    let!(:product_draft) { create(:product, status: 'draft', title: 'Novembro de 63') }
    let!(:product_active) { create(:product, status: 'active', title: 'O silêncio dos inocentes') }

    it 'all' do
      visit products_path

      expect(page).to have_content(I18n.t('views.products'))
      expect(page).to have_content(product_draft.title)
      expect(page).to have_content(product_draft.category.name)

      expect(page).to have_content(product_active.title)
      expect(page).to have_content(product_active.category.name)
    end

    it 'actives' do
      visit products_path(status: 'active')

      expect(page).to_not have_content(product_draft.title)
      expect(page).to_not have_content(product_draft.category.name)

      expect(page).to have_content(product_active.title)
      expect(page).to have_content(product_active.category.name)
    end

    it 'drafts' do
      visit products_path(status: 'draft')

      expect(page).to have_content(product_draft.title)
      expect(page).to have_content(product_draft.category.name)

      expect(page).to_not have_content(product_active.title)
      expect(page).to_not have_content(product_active.category.name)
    end
  end

  context 'search by title' do
    let!(:product1) { create(:product, title: 'Adimirável Mundo Novo') }
    let!(:product2) { create(:product, title: 'Mundo da Lua') }
    let!(:product3) { create(:product, title: 'O Andarilho') }

    it do
      visit products_path
      fill_in 'search', with: 'mundo'

      click_button 'Buscar'

      expect(page).to have_content(product1.title)
      expect(page).to have_content(product1.category.name)

      expect(page).to have_content(product2.title)
      expect(page).to have_content(product2.category.name)

      expect(page).to_not have_content(product3.title)
      expect(page).to_not have_content(product3.category.name)
    end
  end
end
