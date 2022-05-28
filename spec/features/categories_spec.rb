# frozen_string_literal: true

require 'rails_helper'

describe 'Categories' do
  let!(:category) { create(:category) }
  it 'Display categories' do
    visit categories_path

    expect(page).to have_content(I18n.t('views.categories'))
    expect(page).to have_content(category.name)
  end
end
