# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe 'GET #index' do
    let(:category) { create(:category) }

    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end

    it 'assigns @users' do
      get :index
      expect(assigns(:categories)).to eq(Category.all)
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get :new
      expect(response).to be_successful
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template('new')
    end

    it 'assigns new category' do
      get :new
      expect(assigns(:category)).to be_a_new(Category)
    end
  end

  describe 'POST #create' do
    context 'successful' do
      it 'creates a new category' do
        expect do
          post :create, params: {
            category: {
              name: Faker::Book.genre
            }
          }
        end.to change(Category, :count).by(1)
      end

      it 'redirect to index and show flash message' do
        post :create, params: { category: { name: Faker::Book.genre } }

        expect(response).to redirect_to(action: :index)
        expect(flash[:success]).to eq(I18n.t('categories.flash.actions.create.notice'))
      end
    end

    context 'unsuccessful' do
      it 'whitout name' do
        post :create, params: { category: { name: nil } }

        expect(response).to render_template(:new)
        expect(flash[:danger]).to eq(I18n.t('categories.flash.actions.create.danger.name'))
      end
    end
  end
end
