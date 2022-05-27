# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe 'GET #index' do
    let(:product) { create(:product) }

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
      expect(assigns(:products)).to eq(Product.all)
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

    it 'assigns new product' do
      get :new
      expect(assigns(:product)).to be_a_new(Product)
    end
  end

  describe 'POST #create' do
    let(:category) { create(:category) }

    context 'successful' do
      it 'creates a new product' do
        expect do
          post :create, params: {
            product: {
              title: Faker::Book.title,
              content: Faker::Lorem.paragraph,
              price: 3_000,
              comparation_price: 2_990,
              status: 'draft',
              category_id: category.id
            }
          }
        end.to change(Product, :count).by(1)
      end

      it 'redirect to index and show flash message' do
        post :create, params: { product: { title: Faker::Book.title,
                                           content: Faker::Lorem.paragraph,
                                           price: 3_000,
                                           comparation_price: 2_990,
                                           status: 'draft',
                                           category_id: category.id } }

        expect(response).to redirect_to(action: :index)
        expect(flash[:success]).to eq(I18n.t('products.flash.actions.create.notice'))
      end
    end

    context 'unsuccessful' do
      it 'whitout title' do
        post :create, params: { product: { title: nil,
                                           content: Faker::Lorem.paragraph,
                                           price: 3_000,
                                           comparation_price: 2_990,
                                           status: 'draft',
                                           category_id: category.id } }

        expect(response).to render_template(:new)
        expect(flash[:danger]).to eq(I18n.t('products.flash.actions.create.danger.title'))
      end

      it 'whitout content' do
        post :create, params: { product: { title: Faker::Book.title,
                                           content: nil,
                                           price: 3_000,
                                           comparation_price: 2_990,
                                           status: 'draft',
                                           category_id: category.id } }

        expect(response).to render_template(:new)
        expect(flash[:danger]).to eq(I18n.t('products.flash.actions.create.danger.description'))
      end

      it 'whitout price' do
        post :create, params: { product: { title: Faker::Book.title,
                                           content: Faker::Lorem.paragraph,
                                           price: nil,
                                           comparation_price: 2_990,
                                           status: 'draft',
                                           category_id: category.id } }

        expect(response).to render_template(:new)
        expect(flash[:danger]).to eq(I18n.t('products.flash.actions.create.danger.price'))
      end

      it 'when comparation_price is higher than price' do
        post :create, params: { product: { title: Faker::Book.title,
                                           content: Faker::Lorem.paragraph,
                                           price: 3_000,
                                           comparation_price: 4_990,
                                           status: 'draft',
                                           category_id: category.id } }

        expect(response).to render_template(:new)
        expect(flash[:danger]).to eq(I18n.t('products.flash.actions.create.danger.comparation_price'))
      end

      it 'whitout status' do
        post :create, params: { product: { title: Faker::Book.title,
                                           content: Faker::Lorem.paragraph,
                                           price: 3_000,
                                           comparation_price: 2_990,
                                           status: nil,
                                           category_id: category.id } }

        expect(response).to render_template(:new)
        expect(flash[:danger]).to eq(I18n.t('products.flash.actions.create.danger.status'))
      end

      it 'whitout category_id' do
        post :create, params: { product: { title: Faker::Book.title,
                                           content: Faker::Lorem.paragraph,
                                           price: 3_000,
                                           comparation_price: 2_990,
                                           status: 'draft',
                                           category_id: nil } }

        expect(response).to render_template(:new)
        expect(flash[:danger]).to eq(I18n.t('products.flash.actions.create.danger.category'))
      end
    end
  end
end
