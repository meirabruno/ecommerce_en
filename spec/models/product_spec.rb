# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  subject { build(:product) }

  describe 'associations' do
    it { should have_many(:categorizations) }
    it { should have_many(:categories) }
  end
end
