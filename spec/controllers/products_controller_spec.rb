# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe 'GET #index' do
    context 'simple tests' do
      let!(:product) { create(:product) }

      it 'returns a successful response' do
        get :index
        expect(response).to be_successful
      end

      it 'renders the index template' do
        get :index
        expect(response).to render_template('index')
      end

      it 'assigns @products' do
        get :index
        expect(assigns(:products)).to eq(Product.all.order(:created_at))
      end
    end

    context 'filter by status' do
      let!(:product_draft) { create(:product, status: 'draft') }
      let!(:product_active) { create(:product, status: 'active') }

      it 'list only draft' do
        get :index, params: { status: 'draft' }
        expect(assigns(:products)).to eq(Product.status('draft').order(:created_at))
      end

      it 'list only active' do
        get :index, params: { status: 'active' }
        expect(assigns(:products)).to eq(Product.status('active').order(:created_at))
      end
    end

    context 'search by title' do
      let!(:product1) { create(:product, title: 'Adimirável Mundo Novo') }
      let!(:product2) { create(:product, title: 'Mundo da Lua') }
      let!(:product3) { create(:product, title: 'O Andarilho') }

      it do
        get :index, params: { search: 'mundo' }
        expect(assigns(:products)).to eq([product1, product2])
      end
    end

    context 'order by column' do
      let!(:category1) { create(:category, name: 'Aviação') }
      let!(:category2) { create(:category, name: 'Barcos') }
      let!(:product1) { create(:product, title: 'Adimirável Mundo Novo', status: 'draft', category: category1) }
      let!(:product2) { create(:product, title: 'Mundo da Lua', status: 'active', category: category2) }

      it 'order by title asc' do
        get :index, params: { field: 'title', order: 'asc' }
        expect(assigns(:products).first).to eq(product1)
      end

      it 'order by title desc' do
        get :index, params: { field: 'title', order: 'desc' }
        expect(assigns(:products).first).to eq(product2)
      end

      it 'order by status asc' do
        get :index, params: { field: 'status', order: 'asc' }
        expect(assigns(:products).first).to eq(product2)
      end

      it 'order by status desc' do
        get :index, params: { field: 'status', order: 'desc' }
        expect(assigns(:products).first).to eq(product1)
      end

      it 'order by category asc' do
        get :index, params: { field: 'category', order: 'asc' }
        expect(assigns(:products).first).to eq(product1)
      end

      it 'order by category desc' do
        get :index, params: { field: 'category', order: 'desc' }
        expect(assigns(:products).first).to eq(product2)
      end
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

  describe 'GET #edit' do
    let!(:product) { create(:product) }

    it 'returns a successful response' do
      get :edit, params: { id: product.id }
      expect(response).to be_successful
    end

    it 'renders the edit template' do
      get :edit, params: { id: product.id }
      expect(response).to render_template('edit')
    end

    it 'assigns edit product' do
      get :edit, params: { id: product.id }
      expect(assigns(:product)).to eq(product)
    end
  end

  describe 'PATCH #update' do
    let(:category) { create(:category) }
    let!(:product) { create(:product, title: 'Primeiro Title') }

    context 'successful' do
      it 'update a product' do
        patch :update, params: { id: product.id, product: { title: 'Outro Title',
                                                            content: Faker::Lorem.paragraph,
                                                            status: 'draft',
                                                            price: 3_000,
                                                            comparation_price: 2_990,
                                                            category_id: category.id } }

        product.reload
        expect(product.title).to eq('Outro Title')
      end

      it 'redirect to index and show flash message' do
        patch :update, params: { id: product.id, product: { title: 'Outro Title',
                                                            content: Faker::Lorem.paragraph,
                                                            status: 'draft',
                                                            price: 3_000,
                                                            comparation_price: 2_990,
                                                            category_id: category.id } }

        product.reload

        expect(response).to redirect_to(action: :index)
        expect(flash[:success]).to eq(I18n.t('products.flash.actions.update.notice'))
      end
    end

    context 'unsuccessful' do
      it 'whitout title' do
        patch :update, params: { id: product.id, product: { title: nil,
                                                            content: Faker::Lorem.paragraph,
                                                            price: 3_000,
                                                            comparation_price: 2_990,
                                                            status: 'draft',
                                                            category_id: category.id } }

        expect(response).to render_template(:edit)
        expect(flash[:danger]).to eq(I18n.t('products.flash.actions.create.danger.title'))
      end

      it 'whitout content' do
        patch :update, params: { id: product.id, product: { title: Faker::Book.title,
                                                            content: nil,
                                                            price: 3_000,
                                                            comparation_price: 2_990,
                                                            status: 'draft',
                                                            category_id: category.id } }

        expect(response).to render_template(:edit)
        expect(flash[:danger]).to eq(I18n.t('products.flash.actions.create.danger.description'))
      end

      it 'whitout price' do
        patch :update, params: { id: product.id, product: { title: Faker::Book.title,
                                                            content: Faker::Lorem.paragraph,
                                                            price: nil,
                                                            comparation_price: 2_990,
                                                            status: 'draft',
                                                            category_id: category.id } }

        expect(response).to render_template(:edit)
        expect(flash[:danger]).to eq(I18n.t('products.flash.actions.create.danger.price'))
      end

      it 'when comparation_price is higher than price' do
        patch :update, params: { id: product.id, product: { title: Faker::Book.title,
                                                            content: Faker::Lorem.paragraph,
                                                            price: 3_000,
                                                            comparation_price: 4_990,
                                                            status: 'draft',
                                                            category_id: category.id } }

        expect(response).to render_template(:edit)
        expect(flash[:danger]).to eq(I18n.t('products.flash.actions.create.danger.comparation_price'))
      end

      it 'whitout status' do
        patch :update, params: { id: product.id, product: { title: Faker::Book.title,
                                                            content: Faker::Lorem.paragraph,
                                                            price: 3_000,
                                                            comparation_price: 2_990,
                                                            status: nil,
                                                            category_id: category.id } }

        expect(response).to render_template(:edit)
        expect(flash[:danger]).to eq(I18n.t('products.flash.actions.create.danger.status'))
      end

      it 'whitout category_id' do
        patch :update, params: { id: product.id, product: { title: Faker::Book.title,
                                                            content: Faker::Lorem.paragraph,
                                                            price: 3_000,
                                                            comparation_price: 2_990,
                                                            status: 'draft',
                                                            category_id: nil } }

        expect(response).to render_template(:edit)
        expect(flash[:danger]).to eq(I18n.t('products.flash.actions.create.danger.category'))
      end
    end
  end

  describe 'DELETE #remove_products' do
    let!(:product1) { create(:product) }
    let!(:product2) { create(:product) }
    let!(:product3) { create(:product) }

    context 'successful' do
      it 'remove one product' do
        delete :remove_products, params: { ids: [product1.id] }

        expect(Product.all.ids).to match_array([product2.id, product3.id])
      end

      it 'remove many products' do
        delete :remove_products, params: { ids: [product1.id, product2.id] }

        expect(Product.all.ids).to match_array([product3.id])
      end
    end

    context 'unsuccessful' do
      it 'when not send ids' do
        delete :remove_products, params: { ids: [] }

        expect(Product.all.ids).to match_array([product1.id, product2.id, product3.id])
      end
    end
  end
end
