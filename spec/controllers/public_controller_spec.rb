# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublicController, type: :controller do
  describe 'GET #home' do
    let!(:product_active) { create(:product, status: 'active') }
    let!(:product_draft) { create(:product, status: 'draft') }

    it 'returns a successful response' do
      get :home
      expect(response).to be_successful
    end

    it 'renders the home template' do
      get :home
      expect(response).to render_template('home')
    end

    it 'assigns @products' do
      get :home
      expect(assigns(:products)).to eq([product_active])
    end
  end
end
